extends BaseSkills

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	Board.highlight_tiles([player.board_cood+Vector2(1,0),player.board_cood+Vector2(1,0)],GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	Board.reset_all_tile()
	
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

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
