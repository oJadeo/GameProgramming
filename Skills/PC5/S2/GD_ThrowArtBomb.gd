extends BaseSkills

@export var range:int = 4
@export var bomb:Resource
var spawn_bomb = null
@onready var bomb_timer = $ArtBombTimer
var velocity = Vector2.ZERO
var target_list:Array = []
@onready var audioPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for i in range(1,range+1,1):
		cood_list.append(player.board_cood+Vector2(i,0))
		cood_list.append(player.board_cood-Vector2(i,0))
	Board.highlight_tiles(cood_list,GET_TILE.all)

func select_target(cood:Vector2) -> void:
	super(cood)
	target_list = []
	var dir_list = [Vector2(0,0),Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
	for dir in dir_list:
		var target = Board.get_character(cood+dir)
		if target:
			target_list.append(target)
	velocity = Board.get_tile_pos(cood) - player.global_position
	
	player.direction = Vector2(cood.x - player.board_cood.x,0).normalized()
	
	Board.reset_all_tile()
	audioPlayer.seek(1.25)
	audioPlayer.play()
	player.play_animaiton("Cast") 
	player.move_timer.set_wait_time(2)
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
	if not bomb_timer.is_stopped():
		spawn_bomb.global_position.x += velocity.x*delta*4

func finish_skill() -> void:
	super()
	for target in target_list:
		target.damaged(player.stat.atk*0.75,player.direction)
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	bomb_timer.start()
	spawn_bomb = bomb.instantiate()
	add_child(spawn_bomb)
	spawn_bomb.set_direction(player.direction)


func _on_art_bomb_timer_timeout():
	spawn_bomb.play_bomb()
