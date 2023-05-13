extends BaseSkills

var target:Character
@export var range:int = 9
@export var shuriken:Resource
var spawn_shuriken = null
@onready var shuriken_spawn_point = $ShurikenSpawnLocation
@onready var shuriken_timer = $ShurikenTimer
@onready var audioPlayer = $AudioStreamPlayer
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for i in range(1,range+1,1):
		cood_list.append(player.board_cood+Vector2(i,0))
		cood_list.append(player.board_cood-Vector2(i,0))
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	velocity = Board.get_tile_pos(cood) - shuriken_spawn_point.global_position
	
	player.direction = Vector2(cood.x - player.board_cood.x,0).normalized()
	
	Board.reset_all_tile()
	player.play_animaiton("Shuriken")
	audioPlayer.play()
	audioPlayer.seek(1.1)
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
	if not shuriken_timer.is_stopped():
		spawn_shuriken.global_position.x += velocity.x*delta*5

func finish_skill() -> void:
	super()
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	shuriken_timer.start()
	spawn_shuriken = shuriken.instantiate()
	add_child(spawn_shuriken)
	spawn_shuriken.set_position(shuriken_spawn_point.get_position())
	


func _on_shuriken_timer_timeout() -> void:
	target.damaged(player.stat.atk*1.5,player.direction)
	spawn_shuriken.queue_free()
	audioPlayer.stop()
