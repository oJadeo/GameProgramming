extends BaseSkills

var amount:int  = 0
var skill_direction:Vector2 = Vector2.ZERO
var up_player
var down_player
@export var buff_duration:int = 3
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for character in Board.player_list:
		cood_list.append(character.board_cood)
	Board.highlight_tiles(cood_list,GET_TILE.unit)
	
func set_up(_amount:int,_skill_direction:Vector2) -> void:
	amount = _amount
	skill_direction = _skill_direction

func select_target(cood:Vector2) -> void:
	super(cood)
	player.direction = skill_direction
	Board.reset_all_tile()
	
	player.formation_use -= 1
	if player.direction == Vector2(1,0):
		up_player = Board.get_character(player.board_cood-Vector2(2,1))
		down_player = Board.get_character(player.board_cood-Vector2(2,-1))
	else:
		up_player = Board.get_character(player.board_cood+Vector2(2,1))
		down_player = Board.get_character(player.board_cood+Vector2(2,-1))
	# Every one cast
	player.play_animaiton("Cast") 
	up_player.play_animaiton("Cast") 
	down_player.play_animaiton("Cast") 
	
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	var can_do = false
	if Board.get_character(player.board_cood+Vector2(2,1)) in Board.player_list and Board.get_character(player.board_cood+Vector2(2,-1)) in Board.player_list :
		can_do = true
		skill_direction = Vector2(-1,0)
	if Board.get_character(player.board_cood-Vector2(2,1)) in Board.player_list and Board.get_character(player.board_cood-Vector2(2,-1)) in Board.player_list :
		can_do = true
		skill_direction = Vector2(1,0)
	return can_do

func finish_skill() -> void:
	super()
	up_player.return_to_idle()
	down_player.return_to_idle()
	player.end_turn()
		

func update(delta:float) -> void:
	pass

func deselect() -> void:
	Board.reset_all_tile()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	for character in Board.player_list:
		var buff_stat = Status.new()
		buff_stat.atk = character.stat.atk
		buff_stat.def = 0
		buff_stat.speed = 0
		buff_stat.gauge = 0
		character.turn_effect(Character.EFFECT.buff,buff_stat,buff_duration)

