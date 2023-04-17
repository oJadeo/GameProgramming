extends Character

@onready var skills_node = $SkillsList
@onready var idle_timer = $IdleTimer

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
	#idle_timer.start()
	for skill in skill_list:
		if skill.cooldown != 0:
			pass
			
	#Check cood in fromt is empty move 1 cood
	var attackable_cood_list = []
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var atk_front = player_cood + player.direction
		var atk_behind = player_cood - player.direction
		if Board.is_cood_in_board(atk_front) and (not Board.get_character(atk_front) or atk_front==board_cood):
			attackable_cood_list.append([false,atk_front])
		if Board.is_cood_in_board(atk_behind) and (not Board.get_character(atk_behind) or atk_behind==board_cood):
			attackable_cood_list.append([true,atk_behind])
	if [true,board_cood] in attackable_cood_list:
		finish_walk()
	else:
		select_skill(0)
		var target_cood_list = Board.get_highlight()
		var min_behind = false
		var min_dist = 999
		var min_cood = Vector2(-1,-1)
		for target_cood in target_cood_list:
			for attackable_cood in attackable_cood_list:
				var is_back = attackable_cood[0]
				var atk_cood = attackable_cood[1]
				var dist = abs(atk_cood.x-target_cood.x)+abs(atk_cood.y-target_cood.y)
				if dist < min_dist:
					min_dist = dist
					min_cood = target_cood
				elif dist == min_dist and is_back:
					min_dist = dist
					min_cood = target_cood
		if 	[false,board_cood] in attackable_cood_list and min_dist > 0:
			finish_walk()
		elif Board.is_cood_in_board(min_cood):
			selecting_move.select_target(min_cood)
		else:
			finish_walk()
	#if not Board.get_character(board_cood+direction):
	#	
	#	#Select Move
	#	select_skill(0)
	#	
	#	#Example for get tile those move can target
	#	var target_cood_list = Board.get_highlight()
	#	#Select Front Cood
	#	selecting_move.select_target(board_cood+direction)
	#else:
	#	finish_walk()
	#print("Finish Move")
	#finish_walk()

func finish_walk()->void:
	var can_move = false
	for skill in skill_list:
		can_move = can_move or skill.check_target()
	if not can_move:
		end_turn()
	
	#After walk if have character attack
	if Board.get_character(board_cood + Vector2(-1,0)):
		#Select Basic Atk
		if skill_list[2].cooldown == 0:
			select_skill(2)
			print("Skill 2")
		else:
			select_skill(1)
		#Select Front Cood
		selecting_move.select_target(board_cood + Vector2(-1,0))
		
	elif Board.get_character(board_cood + Vector2(1,0)):
		#Select Basic Atk
		if skill_list[2].cooldown == 0:
			select_skill(2)
			print("Skill 2")
		else:
			select_skill(1)
		#Select Front Cood
		selecting_move.select_target(board_cood + Vector2(1,0))
	else:
		end_turn()
	print("End Turn")

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
	print("Wah")
