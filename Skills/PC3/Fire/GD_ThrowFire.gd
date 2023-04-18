extends BaseSkills

@export var range:int = 4
var target_list = []
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
	var target = Board.get_character(cood)
	
	player.direction = Vector2(cood.x - player.board_cood.x,0).normalized()
	
	
	for i in range(1,range+1,1):
		var check =  Board.get_character(player.board_cood+i*player.direction)
		if check:
			target_list.append(check)
	Board.reset_all_tile()
	player.play_animaiton("Fire") 
	player.move_timer.set_wait_time(1.67)
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
	for target in target_list:
		target.damaged(player.stat.atk*0.5,player.direction)

