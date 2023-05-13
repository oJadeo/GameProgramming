extends BaseSkills

var target:Character
var velocity:Vector2 = Vector2.ZERO
@onready var back_slide_timer = $BackSlideTimer
@onready var audioPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = [player.board_cood+Vector2(1,0),player.board_cood-Vector2(1,0)]
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	velocity = Vector2.ZERO
	target = Board.get_character(cood)
	player.direction = (cood - player.board_cood)
	if not Board.get_character(player.board_cood-player.direction) and Board.is_cood_in_board(player.board_cood-player.direction):
		velocity = Board.get_tile_pos(player.board_cood-player.direction) - player.global_position
	Board.reset_all_tile()
	audioPlayer.play()
	player.play_animaiton("Back") 
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	if Board.is_cood_in_board(player.board_cood+Vector2(1,0)):
		return true
	if Board.is_cood_in_board(player.board_cood-Vector2(1,0)):
		return true
	return false

func update(delta:float) -> void:
	if not back_slide_timer.is_stopped():
		player.position += velocity*delta*4

func finish_skill() -> void:
	super()
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	back_slide_timer.start()


func _on_palm_timer_timeout() -> void:
	player.board_cood -= player.direction
	player.global_position = Board.get_tile_pos(player.board_cood)
	if target:
		target.damaged(player.stat.atk,player.direction)
