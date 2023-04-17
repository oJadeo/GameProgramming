extends BaseSkills

@export var range:int = 4
@onready var teleport_timer = $Timer
var teleport_position: Vector2
var player_position: Vector2
var target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var board_size = Board.board_size
	var cood_list = []
	for i in range(board_size.x):
		for j in range(board_size.y):
			cood_list.append(Vector2(i,j))
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player_position = Board.get_tile_pos(player.board_cood)
	teleport_position = Board.get_tile_pos(cood) - Vector2(48,0)
	player.direction = Vector2(cood.x - player.board_cood.x,0).normalized()
	teleport_timer.timeout.connect(teleport_to,CONNECT_ONE_SHOT)
	teleport_timer.start()
	Board.reset_all_tile()
	player.play_animaiton("Teleport") 
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	return true

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

func teleport_to() -> void:
	player.global_position = teleport_position

func teleport_back() -> void:
	player.global_position = player_position

func trigger() -> void:
	target.damaged(player.stat.atk*0.5,player.direction)
	teleport_timer.timeout.connect(teleport_back,CONNECT_ONE_SHOT)
	teleport_timer.start()

