extends BaseSkills

var target:Character
@export var speed_decrease:int = 2
@export var debuff_duration:int = 2
@onready var audioPlayer = $AudioStreamPlayer
var debuff_stat:Status
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debuff_stat = Status.new()

func select() -> void:
	var cood_list = [player.board_cood+Vector2(1,0),player.board_cood+Vector2(-1,0)]
	Board.highlight_tiles(cood_list,GET_TILE.unit)

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	player.direction = Vector2(cood.x - player.board_cood.x,0)
	
	Board.reset_all_tile()
	audioPlayer.seek(1.7)
	audioPlayer.play()
	player.play_animaiton("HitLeg") 
	player.move_timer.set_wait_time(0.5)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	if Board.get_character(player.board_cood+Vector2(1,0)):
		return true
	if Board.get_character(player.board_cood-Vector2(1,0)):
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
	debuff_stat.speed = speed_decrease
	target.damaged(player.stat.atk*0.5,player.direction)
	target.turn_effect(Character.EFFECT.debuff,debuff_stat,debuff_duration)
