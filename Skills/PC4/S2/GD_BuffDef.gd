extends BaseSkills

@export var is_buff:bool
@export var atk:int = 0
@export var def:int = 0
@export var speed:int = 0
@export var gauge:int = 0
@export var buff_duration:int = 0
@export var is_heal:bool
@export var heal_multiplier:float = 1
@export var buff_effect:Resource
@onready var audioPlayer = $AudioStreamPlayer
enum TARGET_MODE{
	SELF,
	ALLY,
	ALL
}
var buff_stat:Status
var target:Character
@export var target_mode:TARGET_MODE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buff_stat = Status.new()
	buff_stat.atk = atk
	buff_stat.def = def
	buff_stat.speed = speed
	buff_stat.gauge = gauge
	pass # Replace with function body.

func select() -> void:
	match target_mode:
		TARGET_MODE.SELF:
			Board.highlight_tiles([player.board_cood],GET_TILE.unit)
		TARGET_MODE.ALLY,TARGET_MODE.ALL:
			var cood_list = []
			for character in Board.player_list:
				cood_list.append(character.board_cood)
			Board.highlight_tiles(cood_list,GET_TILE.unit)
			

func select_target(cood:Vector2) -> void:
	super(cood)
	target = Board.get_character(cood)
	
	Board.reset_all_tile()
	audioPlayer.seek(0.15)
	audioPlayer.play()
	player.play_animaiton("Cast") 
	player.move_timer.set_wait_time(0.75)
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
	match target_mode:
		TARGET_MODE.SELF:
			if is_buff:
				player.turn_effect(Character.EFFECT.buff,buff_stat,buff_duration)
				var buff_instance = buff_effect.instantiate()
				add_child(buff_instance)
				buff_instance.set_effect(true,"def",2)
				buff_instance.global_position = player.global_position -Vector2(0,60)
			if is_heal:
				player.healed(player.stat.atk*heal_multiplier)
		TARGET_MODE.ALLY:
			if is_buff:
				target.turn_effect(Character.EFFECT.buff,buff_stat,buff_duration)
			if is_heal:
				target.healed(player.stat.atk*heal_multiplier)
		TARGET_MODE.ALL:
			for character in Board.player_list:
				if is_buff:
					character.turn_effect(Character.EFFECT.buff,buff_stat,buff_duration)
			for character in Board.player_list:
				if is_heal:
					character.healed(player.stat.atk*heal_multiplier)
