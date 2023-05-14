extends BaseSkills

signal finish_tutorial

var velocity:Vector2
var target_pos:Vector2
var origin_cood:Vector2 = Vector2.ZERO
var origin_diretion:Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	if player.is_move:
		player.board_cood = origin_cood
		player.direction = origin_diretion
		player.global_position = Board.get_tile_pos(origin_cood)
		player.is_move = false
		return
	var cood_list = []
	origin_cood = player.board_cood
	origin_diretion = player.direction
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
	player.is_move = true
		
	if player.board_cood.x > cood.x:
		player.direction = Vector2(-1,0)
	if player.board_cood.x < cood.x:
		player.direction = Vector2(1,0)
	
	if cood.x == player.board_cood.x or cood.y == player.board_cood.y: 
		target_pos = Board.get_tile_pos(cood)
		velocity = target_pos - player.position
		player.board_cood = cood
		
		player.play_animaiton("Walk") 
		
		player.move_timer.set_wait_time(1)
		player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
		player.move_timer.start()
	else:
		var midpoint
		if not Board.get_character(Vector2(cood.x,player.board_cood.y)):
			midpoint = Vector2(cood.x,player.board_cood.y)
		else:
			midpoint = Vector2(player.board_cood.x,cood.y)
			
		target_pos = Board.get_tile_pos(midpoint)
		velocity = target_pos - player.position
		player.board_cood = cood
		
		player.play_animaiton("Walk") 
		
		player.move_timer.set_wait_time(1)
		player.move_timer.timeout.connect(move2.bind(cood),CONNECT_ONE_SHOT)
		player.move_timer.start()
		
func move2(cood:Vector2) -> void:
	target_pos = Board.get_tile_pos(cood)
	velocity = target_pos - player.position
	
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
	emit_signal("finish_tutorial")

func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
