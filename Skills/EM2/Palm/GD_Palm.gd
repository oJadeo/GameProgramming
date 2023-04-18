extends BaseSkills

var target:Character
var velocity:Vector2 = Vector2.ZERO
@onready var palm_timer = $PalmTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	if not Board.get_character(player.board_cood+Vector2(1,0)):
		cood_list.append(player.board_cood+Vector2(2,0))
	if not Board.get_character(player.board_cood-Vector2(1,0)):
		cood_list.append(player.board_cood-Vector2(2,0))
	Board.highlight_tiles(cood_list,GET_TILE.all)

func select_target(cood:Vector2) -> void:
	super(cood)
	
	target = Board.get_character(cood)
	player.direction = (cood - player.board_cood)/2
	velocity = Board.get_tile_pos(player.board_cood+player.direction) - player.position
	Board.reset_all_tile()
	player.play_animaiton("Palm") 
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	if not Board.get_character(player.board_cood+Vector2(1,0)) and Board.is_cood_in_board(player.board_cood+Vector2(2,0)):
		return true
	if not Board.get_character(player.board_cood-Vector2(1,0)) and Board.is_cood_in_board(player.board_cood-Vector2(2,0)):
		return true
	return false

func update(delta:float) -> void:
	if not palm_timer.is_stopped():
		player.position += velocity*delta*3

func finish_skill() -> void:
	super()
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	palm_timer.start()


func _on_palm_timer_timeout() -> void:
	player.board_cood += player.direction
	if target:
		target.damaged(player.stat.atk*0.5,player.direction)
