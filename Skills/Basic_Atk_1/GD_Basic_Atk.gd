extends BaseSkills

var target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	Board.highlight_tiles([player.board_cood-Vector2(1,0),player.board_cood+Vector2(1,0)],GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = cood - player.board_cood
	print(player.direction )
	Board.reset_all_tile()
	player.play_animaiton("Basic_Atk") 
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	var is_target = Board.get_character(player.board_cood-Vector2(1,0))
	if is_target:
		return true
	is_target = Board.get_character(player.board_cood+Vector2(1,0))
	if is_target:
		return true
	return false

func update(delta:float) -> void:
	pass

func finish_skill() -> void:
	super()
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	target.damaged(player.stat.atk,player.direction)
