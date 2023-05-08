extends BaseSkills

var target_list:Array = []
var velocity_list:Array = []
@onready var sweep_timer = $SweepTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for h_dir in [Vector2(1,0),Vector2(-1,0)]:
		for v_dir in [Vector2(0,1),Vector2(0,0),Vector2(0,-1)]:
			cood_list.append(player.board_cood + h_dir + v_dir)
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target_list = []
	velocity_list = []
	var target_dir = Vector2(cood.x - player.board_cood.x,0)
	for v_dir in [Vector2(0,1),Vector2(0,0),Vector2(0,-1)]:
		var target = Board.get_character(player.board_cood+target_dir+v_dir)
		if target:
			var rng = RandomNumberGenerator.new()
			var kicked = rng.randi_range(1,2)
			if Board.get_character(target.board_cood+target_dir*kicked) or not Board.is_cood_in_board(target.board_cood+target_dir*kicked):
				continue
			if Board.get_character(target.board_cood+target_dir):
				continue
			if kicked == 2 and not Board.get_character(target.board_cood+target_dir):
				kicked = 1
			target.board_cood = target.board_cood+target_dir*kicked
			var velocity = Board.get_tile_pos(target.board_cood) - target.global_position

			target_list.append(target)
			velocity_list.append(velocity)
	player.direction = Vector2(cood.x - player.board_cood.x,0)
	
	Board.reset_all_tile()
	player.play_animaiton("Sweep") 
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
	if not sweep_timer.is_stopped():
		for i in range(len(target_list)):
			target_list[i].global_position.x += velocity_list[i].x*delta*4
func finish_skill() -> void:
	super()
	player.end_turn()
	
func deselect() -> void:
	Board.reset_all_tile()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func trigger() -> void:
	sweep_timer.start()
#	for target in target_list: 
#		target.damaged(player.stat.atk,player.direction)
