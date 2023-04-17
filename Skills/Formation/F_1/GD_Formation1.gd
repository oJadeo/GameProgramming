extends BaseSkills

var amount:int  = 0
var skill_direction:int = 0
var damage:int = 0
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	var cood_list:Array = []
	for j in [-1,0,1]:
		for i in [1,2,3]:
			cood_list.append(player.board_cood+Vector2(i,j))
	for j in [-1,0,1]:
		for i in [1,2,3]:
			cood_list.append(player.board_cood-Vector2(i,j))
	Board.highlight_tiles(cood_list,GET_TILE.unit)
	
func set_up(_amount:int,_skill_direction:Vector2) -> void:
	amount = _amount

func select_target(cood:Vector2) -> void:
	super(cood)
	var target = Board.get_character(cood)
	skill_direction = 1 if target.board_cood.x > player.board_cood.x else -1
	player.direction = skill_direction*Vector2(1,0)
	Board.reset_all_tile()
	
	
	# Every one cast
	player.play_animaiton("Punch") 
	player.move_timer.set_wait_time(0.625)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	return Board.get_character(player.board_cood+Vector2(0,1)) in Board.player_list and Board.get_character(player.board_cood-Vector2(0,1)) in Board.player_list

func finish_skill() -> void:
	super()
	player.end_turn()

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	damage = 0
	damage += player.stat.atk
	damage += Board.get_character(player.board_cood+Vector2(0,1)).stat.atk
	damage += Board.get_character(player.board_cood-Vector2(0,1)).stat.atk
	for j in [-1,0,1]:
		for i in [1,2,3]:
			var target = Board.get_character(player.board_cood+Vector2(i,j)*skill_direction)
			if target:
				target.damaged(damage/2,player.direction)
