extends BaseSkills

var target:Character
@export var range:int = 3
@onready var pull_timer = $PullTimer
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for i in range(1,range+1,1):
		if not Board.get_character(player.board_cood+Vector2(1,0)):
			cood_list.append(player.board_cood+Vector2(i,0))
		if not Board.get_character(player.board_cood+Vector2(-1,0)):
			cood_list.append(player.board_cood-Vector2(i,0))
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = Vector2(cood.x - player.board_cood.x,0).normalized()
	velocity = Board.get_tile_pos(player.board_cood+player.direction) -  Board.get_tile_pos(cood) 
	
	Board.reset_all_tile()
	player.play_animaiton("Pull") 
	player.move_timer.set_wait_time(0.5)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	for i in range(1,range+1,1):
		if Board.get_character(player.board_cood+Vector2(i,0)):
			return true
		if Board.get_character(player.board_cood-Vector2(i,0)):
			return true
	return false

func update(delta:float) -> void:
	if not pull_timer.is_stopped():
		target.global_position.x += velocity.x*delta*5

func finish_skill() -> void:
	super()
	target.board_cood = player.board_cood+player.direction
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	pull_timer.start()
