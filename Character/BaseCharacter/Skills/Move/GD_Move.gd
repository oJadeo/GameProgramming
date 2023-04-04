extends BaseSkills

var velocity:Vector2
var target_pos:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for i in range(-2,3):
		for j in range(-2,3):
			if abs(i)+abs(j) <= 2 and abs(i)+abs(j) != 0:
				cood_list.append(player.board_cood+Vector2(i,j))
	Board.highlight_tiles(cood_list,GET_TILE.empty)

func select_target(cood:Vector2) -> void:
	super(cood)
	Board.reset_all_tile()
	target_pos = Board.get_tile_pos(cood)
	velocity = target_pos - player.position
	
	if player.board_cood.x < cood.x:
		player.direction = Vector2(-1,0)
		player.sprite.flip_h = false
	if player.board_cood.x > cood.x:
		player.direction = Vector2(1,0)
		player.sprite.flip_h = true
	player.board_cood = cood
	player.play_animaiton("Walk") 
	
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func update(delta:float) -> void:
	player.position += velocity*delta

func finish_skill() -> void:
	super()
	target_pos
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
