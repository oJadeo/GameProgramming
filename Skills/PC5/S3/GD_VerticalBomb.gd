extends BaseSkills

@export var range:int = 4
@export var bomb:Resource
var spawn_bomb = null
var target
@onready var audioPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for i in range(1,range+1,1):
		cood_list.append(player.board_cood+Vector2(0,i))
		cood_list.append(player.board_cood-Vector2(0,i))
	Board.highlight_tiles(cood_list,GET_TILE.all)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	
	Board.reset_all_tile()
	audioPlayer.play()
	player.play_animaiton("VerticalBomb") 
	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	for i in range(1,range+1,1):
		if Board.get_character(player.board_cood+Vector2(0,i)):
			return true
		if Board.get_character(player.board_cood-Vector2(0,i)):
			return true
	return false

func update(delta:float) -> void:
	pass

func finish_skill() -> void:
	super()
	target.damaged(player.stat.atk,player.direction)
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	spawn_bomb = bomb.instantiate()
	add_child(spawn_bomb)
	spawn_bomb.global_position = target.global_position
	spawn_bomb.set_direction(player.direction)
