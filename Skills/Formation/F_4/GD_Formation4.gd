extends BaseSkills

var amount:int  = 0
var skill_direction:Vector2 = Vector2.ZERO
var target
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	Board.highlight_tiles([player.board_cood+skill_direction],GET_TILE.unit)
	
func set_up(_amount:int,_skill_direction:Vector2) -> void:
	amount = _amount
	skill_direction = _skill_direction

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = skill_direction
	Board.reset_all_tile()
	
	player.formation_use -= 1
	
	#Every one Throw Shuriken
	for i in range(amount):
		var cha = Board.get_character(player.board_cood-i*skill_direction)
		cha.play_animaiton("Shuriken") 
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	var can_do = false
	var direc = [Vector2(1,0),Vector2(-1,0)]
	for dir in direc:
		if Board.get_character(player.board_cood+dir) in Board.player_list:
			can_do = true
			set_up(2,dir*-1)
			if Board.get_character(player.board_cood+dir*2) in Board.player_list:
				set_up(3,dir*-1)
	return can_do

func finish_skill() -> void:
	super()
	player.end_turn()
	for i in range(amount):
		var cha = Board.get_character(player.board_cood-i*skill_direction)
		cha.return_to_idle()
		

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	target.damaged(player.stat.atk*amount,player.direction)

