extends BaseSkills

var target:Character
var push_velocity:Vector2 = Vector2.ZERO
@onready var push_timer = $KickTimer
@onready var audioPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	Board.highlight_tiles([player.board_cood-Vector2(1,0),player.board_cood+Vector2(1,0)],GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = cood - player.board_cood
	if Board.is_cood_in_board(cood+player.direction) and not Board.get_character(cood+player.direction):
		var target_pos = Board.get_tile_pos(cood)
		var pushed_target_pos = Board.get_tile_pos(cood+player.direction)
		push_velocity = (pushed_target_pos-target_pos)*2
		target.board_cood += player.direction
	else:
		push_velocity = Vector2.ZERO
	Board.reset_all_tile()
	player.play_animaiton("Kick")
	audioPlayer.play() 
	player.move_timer.set_wait_time(0.75)
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
	if not push_timer.is_stopped():
		target.position += push_velocity*delta

func finish_skill() -> void:
	super()
	target.position = Board.get_tile_pos(target.board_cood)
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	push_timer.start()
	target.damaged(player.stat.atk*1.5,player.direction)
