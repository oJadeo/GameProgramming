extends Character
class_name PlayerCharacter

@onready var SKILL_SELECT_UI = $CanvasLayer
@onready var btns_node = $CanvasLayer/Skills
@onready var skills_node = $SkillsList
@onready var tooltips = $CanvasLayer/Tooltips
@export var stat_json:JSON
@export var charm_json:JSON
@export var level:int = 1
@export var charm:int = 0

var formation_use:int = 1
var btn_list 
var tooltip_list
var select_formation_skill
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	super()
	SKILL_SELECT_UI.visible = false
	skill_list = skills_node.get_children()
	btn_list = btns_node.get_children()
	tooltip_list = tooltips.get_children()
	setting_skills_button()
	for c in tooltip_list:
		c.visible = false
	is_move = false
	if stat_json:
		get_stat(level)
	
func get_stat(lv:int):
	var stat_data = stat_json.get_data()
	
	stat.atk = stat_data[lv]['atk']
	stat.def = stat_data[lv]['def']
	stat.speed = stat_data[lv]['speed']
	stat.max_health = stat_data[lv]['hp']
	stat.health = stat_data[lv]['hp']
	
	var charm_data = charm_json.get_data()
	
	stat.atk += charm_data[charm]['atk']
	stat.def += charm_data[charm]['def']
	stat.speed += charm_data[charm]['speed']
	stat.max_health += charm_data[charm]['hp']
	stat.health += charm_data[charm]['hp']
	
	
	
func start_turn()->void:
	super()
	if formation_use > 0:
		manager.check_formation(self)
	SKILL_SELECT_UI.visible = true
	# TODO: btn_move have to be texture move
	# btn_list[0].text = "Move"
	# tooltip_list[0].set_move()
	for i in range(len(skill_list)):
		btn_list[i].disabled = skill_list[i].cooldown != 0
func end_turn()->void:
	super()
	SKILL_SELECT_UI.visible = false
	
func setting_skills_button():
	var btn_func = [select_move,select_basic_atk,select_skill_1,select_skill_2]
	var etr_func = [enter_move,enter_basic_atk,enter_skill_1,enter_skill_2]
	
	for btn in btn_list:
		btn.visible = false
	
	for i in range(len(skill_list)):
		btn_list[i].pressed.connect(btn_func[i])
		btn_list[i].mouse_entered.connect(etr_func[i])
		btn_list[i].mouse_exited.connect(exited_skill)
		btn_list[i].visible = true
		skill_list[i].init(self)
	
func select_skill(num:int)->void:
	if num > len(skill_list):
		return
	for i in range(len(skill_list)):
		skill_list[i].deselect()
	selecting_move = skill_list[num]
	select_formation_skill = null
	skill_list[num].select()
func select_move():
	select_skill(0)
func select_basic_atk():
	select_skill(1)
func select_skill_1():
	select_skill(2)
func select_skill_2():
	select_skill(3)
	
func enter_skill(num:int)->void:
	if num >= len(tooltip_list):
		return
	for i in range(len(tooltip_list)):
		tooltip_list[i].visible = false
	tooltip_list[num].visible = true
func enter_move():
	enter_skill(0)
func enter_basic_atk():
	enter_skill(1)
func enter_skill_1():
	enter_skill(2)
func enter_skill_2():
	enter_skill(3)

func exited_skill()->void:
	for i in range(len(tooltip_list)):
		tooltip_list[i].visible = false

func select_formation(formation_skill:BaseSkills) -> void:
	for i in range(len(skill_list)):
		skill_list[i].deselect()
	selecting_move = null
	select_formation_skill = formation_skill

func select_target(cood:Vector2)-> void:
	if is_turn:
		if selecting_move:
			selecting_move.select_target(cood)
		if select_formation_skill:
			select_formation_skill.select_target(cood)

func finish_walk()->void:
	var can_move = false
	can_move = can_move or manager.check_formation(self)
	for skill in skill_list:
		can_move = can_move or skill.check_target()
	if can_move:
		SKILL_SELECT_UI.visible = true
		# TODO: btn_move have to be texture end turn
		# btn_list[0].text = "End Turn"
		# tooltip_list[0].set_end_turn()
	else:
		end_turn()
func targeted() -> void:
	is_target = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not move_timer.is_stopped():
		if selecting_move:
			selecting_move.update(delta)
		if select_formation_skill:
			select_formation_skill.update(delta)

func trigger() -> void:
	if selecting_move:
		selecting_move.trigger()
	if select_formation_skill:
		select_formation_skill.trigger()
