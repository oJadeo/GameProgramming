extends BaseSkills

var target:Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list = []
	for y in [Vector2(0,1),Vector2(0,0),Vector2(0,-1)]:
		for x in [Vector2(1,0),Vector2(-1,0)]:
			cood_list.append(player.board_cood+x+y)
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = Vector2(cood.x - player.board_cood.x,0)
	
	Board.reset_all_tile()
	player.play_animaiton("Punch") 
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	for y in [Vector2(0,1),Vector2(0,0),Vector2(0,-1)]:
		for x in [Vector2(1,0),Vector2(-1,0)]:
			if Board.get_character(player.board_cood+x+y):
				return true
	return false

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


func trigger() -> void:
	target.damaged(player.stat.atk,player.direction)
