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
	idle_timer.start()
	
var target_cood
var move_to_cood
var skill_select

func finish_walk()->void:
	if target_cood != Vector2(-1,-1):
		select_skill(skill_select)
		selecting_move.select_target(target_cood)
	else:
		end_turn()
	#var can_move = false
	#for skill in skill_list:
	#	can_move = can_move or skill.check_target()
	#if not can_move:
	#	end_turn()
	#
	#After walk if have character attack
	#if Board.get_character(board_cood + Vector2(-1,0)):
	#	#Select Basic Atk
	#	if skill_list[2].cooldown == 0:
	#		select_skill(2)
	#	else:
	#		select_skill(1)
	#	#Select Front Cood
	#	selecting_move.select_target(board_cood + Vector2(-1,0))
	#	
	#elif Board.get_character(board_cood + Vector2(1,0)):
	#	#Select Basic Atk
	#	if skill_list[2].cooldown == 0:
	#		select_skill(2)
	#	else:
	#		select_skill(1)
	#	#Select Front Cood
	#	selecting_move.select_target(board_cood + Vector2(1,0))
	#else:
	#	end_turn()

# Called every frame. 'delt	animation.play(name)a' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func check_walk():
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var back_pos = player_cood - player.direction
		if skill_list[2].cooldown == 0 and back_pos == board_cood and not Board.get_character(2*player_cood-board_cood):
			target_cood = player_cood
			skill_select = 2
			return
		if back_pos == board_cood:
			target_cood = player_cood
			skill_select = 1
			return
	
	select_skill(0)
	var movable_coods = Board.get_highlight()
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var back_pos = player_cood - player.direction
			if skill_list[2].cooldown == 0 and back_pos == movable_cood and not Board.get_character(2*player_cood-board_cood):
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 2
				return	
			if back_pos == movable_cood:
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 1
				return
					
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var back_pos = player_cood - player.direction
		if skill_list[2].cooldown == 0 and back_pos == board_cood and not Board.get_character(2*player_cood-board_cood):
			target_cood = player_cood
			skill_select = 2
			return
		for y in [Vector2(0,1),Vector2(0,-1)]:
			if back_pos + y == board_cood:
				target_cood = player_cood
				skill_select = 1
				return

	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var back_pos = player_cood - player.direction
			if skill_list[2].cooldown == 0 and back_pos == movable_cood and not Board.get_character(2*player_cood-board_cood):
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 2
				return	
			for y in [Vector2(0,1),Vector2(0,-1)]:
				if back_pos + y == movable_cood:
					move_to_cood = movable_cood
					target_cood = player_cood
					skill_select = 1
					return
					
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var front_pos = player_cood + player.direction
		if skill_list[2].cooldown == 0 and front_pos == board_cood and not Board.get_character(2*player_cood-board_cood):
			target_cood = player_cood
			skill_select = 2
			return
		if front_pos == board_cood:
			target_cood = player_cood
			skill_select = 1
			return
					
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var front_pos = player_cood + player.direction
			if skill_list[2].cooldown == 0 and front_pos == movable_cood and not Board.get_character(2*player_cood-board_cood):
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 2
				return	
			if front_pos  == movable_cood:
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 1
				return
	
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var front_pos = player_cood + player.direction
		if skill_list[2].cooldown == 0 and front_pos == board_cood and not Board.get_character(2*player_cood-board_cood):
			target_cood = player_cood
			skill_select = 2
			return
		for y in [Vector2(0,1),Vector2(0,-1)]:
			if front_pos + y == board_cood:
				target_cood = player_cood
				skill_select = 1
				return
					
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var front_pos = player_cood + player.direction
			if skill_list[2].cooldown == 0 and front_pos == movable_cood and not Board.get_character(2*player_cood-board_cood):
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 2
				return	
			for y in [Vector2(0,1),Vector2(0,-1)]:
				if front_pos + y == movable_cood:
					move_to_cood = movable_cood
					target_cood = player_cood
					skill_select = 1
					return
					
	var min_dist = 999
	var min_cood = Vector2(-1,-1)
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var dist = abs(movable_cood.x-player_cood.x)+abs(movable_cood.y-player_cood.y)
			if dist < min_dist:
				min_dist = dist
				min_cood = movable_cood
				
	if min_cood != Vector2(-1,-1):
		move_to_cood = min_cood
	return
			
func _on_idle_timer_timeout():
	target_cood = Vector2(-1,-1)
	move_to_cood = Vector2(-1,-1)
	skill_select = -1
	
	check_walk()
	
	if move_to_cood != Vector2(-1,-1):
		select_skill(0)
		selecting_move.select_target(move_to_cood)
	else:
		finish_walk()
	#var attackable_cood_list = []
	#var attack_candidate = [] # [is_backstab,player]
	#for player in Board.player_list:
	#	var player_cood = Board.get_cood(player)
	#	var atk_front = player_cood + player.direction
	#	var atk_behind = player_cood - player.direction
	#	if Board.is_cood_in_board(atk_front) and (not Board.get_character(atk_front) or atk_front==board_cood):
	#		attackable_cood_list.append([false,player])
	#	if Board.is_cood_in_board(atk_behind) and (not Board.get_character(atk_behind) or atk_behind==board_cood):
	#		attackable_cood_list.append([true,player])
	#if [true,board_cood] in attackable_cood_list:
	#	targeted_player = Board.get_character(board_cood)
	#	finish_walk()
	#else:
	#	select_skill(0)
	#	var target_cood_list = Board.get_highlight()
	#	var min_behind = false
	#	var min_dist = 999
	#	var min_cood = Vector2(-1,-1)
	#	for target_cood in target_cood_list:
	#		for attackable_cood in attackable_cood_list:
	#			var is_back = attackable_cood[0]
	#			var atk_cood = attackable_cood[1]
	#			var dist = abs(atk_cood.x-target_cood.x)+abs(atk_cood.y-target_cood.y)
	#			if dist < min_dist:
	#				min_dist = dist
	#				min_cood = target_cood
	#			elif dist == min_dist and is_back:
	#				min_dist = dist
	#				min_cood = target_cood
	#	if 	[false,board_cood] in attackable_cood_list and min_dist > 0:
	#		finish_walk()
	#	elif Board.is_cood_in_board(min_cood):
	#		selecting_move.select_target(min_cood)
	#	else:
	#		finish_walk()
