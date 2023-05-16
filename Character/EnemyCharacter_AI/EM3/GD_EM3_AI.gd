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

# Called every frame. 'delt	animation.play(name)a' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func check_walk():
	target_cood = Vector2(-1,-1)
	move_to_cood = Vector2(-1,-1)
	skill_select = -1
	
	select_skill(0)
	var movable_coods = Board.get_highlight()
	
	if skill_list[2].cooldown == 0:
		target_cood = Board.get_cood(Board.enemy_list[0])
		for enemy in Board.enemy_list:
			if enemy.get_name() == "S_Boss2_AI":
				target_cood = Board.get_cood(enemy)
		skill_select = 2
		var init_dist = 999
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var i_dist = abs(board_cood.x-player_cood.x)+abs(board_cood.y-player_cood.y)
			if init_dist > i_dist:
				init_dist = i_dist
		for movable_cood in movable_coods:
			var min_dist = 999
			var min_cood = Vector2(-1,-1)
			for player in Board.player_list:
				var player_cood = Board.get_cood(player)
				var dist = abs(movable_cood.x-player_cood.x)+abs(movable_cood.y-player_cood.y)
				if min_dist > dist:
					min_dist = dist
					min_cood = movable_cood
			if min_cood != Vector2(-1,-1) and int(min_dist) % 3 == 1 and min_dist < init_dist:
				move_to_cood = min_cood
				return
		return
		
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var back_pos = player_cood - player.direction
		if back_pos == board_cood:
			target_cood = player_cood
			skill_select = 1
			return
	
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var back_pos = player_cood - player.direction
			if back_pos == movable_cood:
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 1
				return
					
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var back_pos = player_cood - player.direction
		for y in [Vector2(0,1),Vector2(0,-1)]:
			if back_pos + y == board_cood:
				target_cood = player_cood
				skill_select = 1
				return

	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var back_pos = player_cood - player.direction
			for y in [Vector2(0,1),Vector2(0,-1)]:
				if back_pos + y == movable_cood:
					move_to_cood = movable_cood
					target_cood = player_cood
					skill_select = 1
					return
					
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var front_pos = player_cood + player.direction
		if front_pos == board_cood:
			target_cood = player_cood
			skill_select = 1
			return
					
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var front_pos = player_cood + player.direction
			if front_pos  == movable_cood:
				move_to_cood = movable_cood
				target_cood = player_cood
				skill_select = 1
				return
	
	for player in Board.player_list:
		var player_cood = Board.get_cood(player)
		var front_pos = player_cood + player.direction
		for y in [Vector2(0,1),Vector2(0,-1)]:
			if front_pos + y == board_cood:
				target_cood = player_cood
				skill_select = 1
				return
					
	for movable_cood in movable_coods:
		for player in Board.player_list:
			var player_cood = Board.get_cood(player)
			var front_pos = player_cood + player.direction
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
	check_walk()
	
	if move_to_cood != Vector2(-1,-1):
		select_skill(0)
		selecting_move.select_target(move_to_cood)
	else:
		finish_walk()
