extends BaseSkills

@export var atk:int = 0
@export var def:int = 0
@export var speed:int = 0
@export var gauge:int = 0
@export var debuff_duration:int = 0
@export var insect:Resource
@onready var audioPlayer = $AudioStreamPlayer
enum TARGET_MODE{
	ENEMY,
	ALL
}
var debuff_stat:Status
@export var target_mode:TARGET_MODE = TARGET_MODE.ALL
var target_list:Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	debuff_stat = Status.new()
	debuff_stat.atk = atk
	debuff_stat.def = def
	debuff_stat.speed = speed
	debuff_stat.gauge = gauge

func select() -> void:
	var cood_list = []
	for character in Board.player_list:
		cood_list.append(character.board_cood)
	Board.highlight_tiles(cood_list,GET_TILE.unit)
			

func select_target(cood:Vector2) -> void:
	target_list = []
	super(cood)
	
	match target_mode:
		TARGET_MODE.ENEMY:
			target_list.append(Board.get_character(cood))
		TARGET_MODE.ALL:
			target_list = Board.player_list
					
	Board.reset_all_tile()
	audioPlayer.seek(0.45)
	audioPlayer.play()
	player.play_animaiton("Insect_All") 
	player.move_timer.set_wait_time(4)
	player.move_timer.timeout.connect(finish_skill,CONNECT_ONE_SHOT)
	player.move_timer.start()

func check_target()->bool:
	return true

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
		print(target.global_position)
		target.turn_effect(Character.EFFECT.debuff,debuff_stat,debuff_duration)
		var new_insect = insect.instantiate()
		get_tree().current_scene.add_child(new_insect)
		new_insect.set_position(target.global_position)
