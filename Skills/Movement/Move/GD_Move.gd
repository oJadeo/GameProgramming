extends BaseSkills

var velocity:Vector2
var target_pos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	if player.is_move:
		player.end_turn()
		return
	var cood_list = []
	check_tile(player.board_cood,player.move_range)
	Board.highlight_tiles(cood_list,GET_TILE.empty)

func check_tile(cood:Vector2,range:int) -> bool:
	var can_move = false
	if cood != player.board_cood:
		if Board.get_character(cood):
			return false
		else:
			Board.highlight_tiles([cood],GET_TILE.empty)
	if range > 0:
		can_move = check_tile(cood+Vector2(1,0),range-1) or  can_move
		can_move = check_tile(cood+Vector2(0,1),range-1) or  can_move
		can_move = check_tile(cood+Vector2(-1,0),range-1) or  can_move
		can_move = check_tile(cood+Vector2(0,-1),range-1) or  can_move
	return true


func check_target()->bool:
	if player.is_move:
		return false

	return check_tile(player.board_cood,player.move_range)

func select_target(cood:Vector2) -> void:
	super(cood)
	Board.reset_all_tile()
	target_pos = Board.get_tile_pos(cood)
	velocity = target_pos - player.position
	
	player.is_move = true
	
	if player.board_cood.x > cood.x:
		player.direction = Vector2(-1,0)
	if player.board_cood.x < cood.x:
		player.direction = Vector2(1,0)
	player.board_cood = cood
	player.play_animaiton("Walk") 
	
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func update(delta:float) -> void:
	player.position += velocity*delta

func finish_skill() -> void:
	super()
	player.play_animaiton("Idle") 
	player.finish_walk()

func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
