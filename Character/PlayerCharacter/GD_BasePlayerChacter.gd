extends Character
class_name PlayerCharacter

@onready var SKILL_SELECT_UI = $CanvasLayer
@onready var move_btn = $CanvasLayer/VBoxContainer/Move
@onready var basic_atk_btn = $CanvasLayer/VBoxContainer/Basic_atk
@onready var w_skill_btn = $CanvasLayer/VBoxContainer/Weapon_Skill
@onready var c_skill_btn = $CanvasLayer/VBoxContainer/Character_Skill

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	super()
	SKILL_SELECT_UI.visible = false
	setting_skills_button()
	is_move = false
	
func start_turn()->void:
	super()
	is_move = false
	SKILL_SELECT_UI.visible = true
	move_btn.visible = true
func end_turn()->void:
	super()
	SKILL_SELECT_UI.visible = false
	get_parent().end_turn()
func setting_skills_button():
	if move:
		add_to_skill_list(move)
		move_btn.pressed.connect(select_move)
	else:
		move_btn.visible = false
	if basic_attack:
		add_to_skill_list(basic_attack)
		basic_atk_btn.pressed.connect(select_basic_atk)
	else:
		basic_atk_btn.visible = false
	if weapon_skill:
		add_to_skill_list(weapon_skill)
		w_skill_btn.pressed.connect(select_weapon)
	else:
		w_skill_btn.visible = false
	if character_skill:
		add_to_skill_list(character_skill)
		c_skill_btn.pressed.connect(select_character)	
	else:
		c_skill_btn.visible = false
func add_to_skill_list(skill:Resource):
	var new_skill = skill.instantiate()
	add_child(new_skill)
	new_skill.init(self)
	skill_list.append(new_skill)
	
func select_skill(num:int)->void:
	if num > len(skill_list):
		return
	for i in range(len(skill_list)):
		skill_list[i].deselect()
	selecting_move = skill_list[num]
	skill_list[num].select()
func select_move():
	select_skill(0)
	move_btn.visible = false
	SKILL_SELECT_UI.visible = false
func select_basic_atk():
	select_skill(1)
func select_weapon():
	select_skill(2)
func select_character():
	select_skill(3)

func select_target(cood:Vector2)-> void:
	selecting_move.select_target(cood)
func play_animaiton(name:String)->void:
	animation.play(name)
func finish_walk()->void:
	var can_move = false
	for skill in skill_list:
		can_move = can_move or skill.check_target()
	if can_move:
		SKILL_SELECT_UI.visible = true
	else:
		end_turn()
func targeted() -> void:
	is_target = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if not move_timer.is_stopped():
		selecting_move.update(delta)
