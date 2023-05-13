extends BaseSkills

var target:Character
var velocity:Vector2 = Vector2.ZERO
@onready var thunder_timer = $ThunderTimer
@onready var hurt_timer =$Hurt_Timer
@onready var audioPlayer = $AudioStreamPlayer
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
	target.board_cood = target_cood(cood,player.direction)
	velocity = (Board.get_tile_pos(target.board_cood) - target.global_position)/3*2
	Board.reset_all_tile()
	audioPlayer.play()
	player.play_animaiton("Thunder") 
	player.move_timer.set_wait_time(3.5)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	if Board.get_character(player.board_cood+Vector2(1,0)):
		return true
	if Board.get_character(player.board_cood-Vector2(1,0)):
		return true
	return false

func target_cood(cur_cood:Vector2,dir:Vector2) -> Vector2:
	print(cur_cood)
	var character = Board.get_character(cur_cood+dir)
	if character or not Board.is_cood_in_board(cur_cood+dir):
		return cur_cood
	return target_cood(cur_cood + dir,dir)

func update(delta:float) -> void:
	if not thunder_timer.is_stopped():
		target.global_position.x += velocity.x*delta
		player.global_position.x += velocity.x*delta

func finish_skill() -> void:
	super()
	target.global_position = Board.get_tile_pos(target.board_cood)
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	thunder_timer.start()
	hurt_timer.start()
	target.damaged(player.stat.atk*0.75,player.direction)


func _on_thunder_timer_timeout():
	player.global_position = Board.get_tile_pos(player.board_cood)


func _on_hurt_timer_timeout():
	target.play_animaiton("Hurt")
	if not thunder_timer.is_stopped():
		hurt_timer.start()
