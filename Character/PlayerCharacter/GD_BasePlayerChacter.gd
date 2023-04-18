extends Character
class_name PlayerCharacter

@onready var SKILL_SELECT_UI = $CanvasLayer
@onready var btns_node = $CanvasLayer/VBoxContainer
@onready var skills_node = $SkillsList
var formation_use:int = 1
var btn_list 
var select_formation_skill
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	super()
	SKILL_SELECT_UI.visible = false
	skill_list = skills_node.get_children()
	btn_list = btns_node.get_children()
	setting_skills_button()
	is_move = false
	
func start_turn()->void:
	super()
	if formation_use > 0:
		manager.check_formation(self)
	SKILL_SELECT_UI.visible = true
	btn_list[0].text = "Move"
	for i in range(len(skill_list)):
		btn_list[i].disabled = skill_list[i].cooldown != 0
func end_turn()->void:
	super()
	SKILL_SELECT_UI.visible = false
	
func setting_skills_button():
	var btn_func = [select_move,select_basic_atk,select_skill_1,select_skill_2]
	
	for btn in btn_list:
		btn.visible = false
	
	for i in range(len(skill_list)):
		btn_list[i].pressed.connect(btn_func[i])
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
		btn_list[0].text = "End Turn"
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
