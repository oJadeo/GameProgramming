extends BaseSkills

var target:Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = [player.board_cood+Vector2(1,0),player.board_cood+Vector2(-1,0)]
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = Vector2(cood.x - player.board_cood.x,0)
	
	Board.reset_all_tile()
	player.play_animaiton("GaugePunch") 
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	if Board.get_character(player.board_cood+Vector2(1,0)):
		return true
	if Board.get_character(player.board_cood-Vector2(1,0)):
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
	target.stat.gauge = 0
