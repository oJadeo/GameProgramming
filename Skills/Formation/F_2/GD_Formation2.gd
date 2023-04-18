extends BaseSkills

var amount:int  = 0
var target_pos:Array = []
var damage:int = 0
var duo :PlayerCharacter
var target
@onready var down_timer = $StartDownTimer
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	Board.highlight_tiles(target_pos,GET_TILE.unit)
	
func set_up(_amount:int,_skill_direction:Vector2) -> void:
	amount = _amount

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	var target_direction:Vector2 = target.board_cood - player.board_cood
	duo = Board.get_character(player.board_cood+2*target_direction)
	damage = player.stat.atk + duo.stat.atk
	Board.reset_all_tile()
	
	# Up ATk + Down ATk
	if target_direction == Vector2(0,-1):
		player.play_animaiton("Up_Atk") 
		down_timer.timeout.connect(play_down.bind(duo),CONNECT_ONE_SHOT)
		down_timer.start()

	if target_direction == Vector2(0,1):
		duo.play_animaiton("Up_Atk") 
		down_timer.timeout.connect(play_down.bind(player),CONNECT_ONE_SHOT)
		down_timer.start()

	player.move_timer.set_wait_time(1)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()
func check_target()->bool:
	target_pos.clear()
	var can_do:bool = false
	if Board.get_character(player.board_cood+Vector2(0,2)) in Board.player_list:
		can_do = true
		target_pos.append(player.board_cood+Vector2(0,1))
	if Board.get_character(player.board_cood-Vector2(0,2)) in Board.player_list:
		can_do = true
		target_pos.append(player.board_cood-Vector2(0,1))
	return can_do

func finish_skill() -> void:
	super()
	duo.return_to_idle()
	duo = null
	player.end_turn()

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_down(char:PlayerCharacter) -> void:
	char.play_animaiton("Down_Atk") 
	trigger()

func trigger() -> void:
	target.damaged(damage,-1*target.direction)
	target.stat.gauge = 0 if target.stat.gauge <= 50 else  target.stat.gauge - 50

