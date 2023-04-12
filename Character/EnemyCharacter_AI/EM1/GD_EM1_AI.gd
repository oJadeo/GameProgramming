extends Character

@onready var skills_node = $SkillsList
@onready var idle_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	#Skill in skill_list in order = [move,BasicAtk,Skill1,Skill2] ไม่ได้ชื่อนี้เป๊ะๆ แต่เรียงแบบนี้
	skill_list = skills_node.get_children()
	#Setting for skill
	for skill in skill_list:
		skill.init(self)

func start_turn()->void:
	super()
	
	idle_timer.start()
	

func finish_walk()->void:
	var can_move = false
	for skill in skill_list:
		can_move = can_move or skill.check_target()
	if not can_move:
		end_turn()
	
	#After walk if have character attack
	if Board.get_character(board_cood+direction):
		#Select Basic Atk
		select_skill(1)
		#Select Front Cood
		selecting_move.select_target(board_cood+direction)
		

# Called every frame. 'delt	animation.play(name)a' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func _on_timer_timeout() -> void:
	#Check Cooldown
	for skill in skill_list:
		if skill.cooldown != 0:
			pass
			
	#Check cood in fromt is empty move 1 cood
	if not Board.get_character(board_cood+direction):
		
		#Select Move
		select_skill(0)
		
		#Example for get tile those move can target
		var target_cood_list = Board.get_highlight()
		
		#Select Front Cood
		selecting_move.select_target(board_cood+direction)
