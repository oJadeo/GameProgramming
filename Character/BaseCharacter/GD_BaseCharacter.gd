extends Node2D
class_name Character

signal death(object)


class status:
	signal atk_updated(new_value)
	signal def_updated(new_value)
	signal speed_updated(new_value)
	signal health_updated(new_value)
	signal max_health_updated(new_value)
	signal gauge_updated(new_value)
	var atk: int = 0:
		set(new_value):
			atk = new_value
			emit_signal('atk_updated',new_value)
	var def: int = 0:
		set(new_value):
			def = new_value
			emit_signal('def_updated',new_value)
	var speed: int = 10:
		set(new_value):
			speed = new_value
			emit_signal('speed_updated',new_value)
	var health: int = 0:
		set(new_value):
			if new_value < 0:
				emit_signal('death',self)
				return
			health = new_value if new_value < max_health else max_health
			emit_signal('health_updated',new_value)
	var max_health:int = 1:
		set(new_value):
			health = new_value
			emit_signal('max_health_updated',new_value)
	var gauge:float = 0.0:
		set(new_value):
			gauge = new_value 
			emit_signal('gauge_updated',new_value)
	func _init():
		pass
var stat = status.new()

@export var start_atk:int = 1
@export var start_def:int = 1
@export var start_speed:int = 10
@export var start_max_health:int = 1

@export var move:Resource
@export var basic_attack:Resource
@export var weapon_skill:Resource
@export var character_skill:Resource

var damage_display = preload("res://System/Damage/S_DamageNuber.tscn")

@export var start_direction:Vector2 = Vector2(1,0)
var direction:Vector2 = Vector2(1,0)
@export var start_cood:Vector2 = Vector2(-1,-1)
var board_cood:Vector2 = Vector2(-1,-1):
	set(new_value):
		Board.change_cood(self,new_value)
		board_cood = new_value

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var move_timer = $MoveTimer

var is_turn:bool = false
var is_target:bool = false

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	if start_cood == Vector2(-1,-1):
		return
	board_cood = start_cood
	set_global_position(Board.get_tile_pos(board_cood))
	set_up_start_stat()
	animation.play("Idle")
	animation.stop()
	
func set_up_start_stat():
	stat.atk = start_atk
	stat.def = start_def
	stat.speed = start_speed
	stat.max_health = start_max_health
	stat.health = start_max_health
	direction = start_direction
	sprite.flip_h = direction != Vector2(1,0)

func update_tick(delta:float)->bool:
	stat.gauge = stat.gauge + stat.speed*delta
	return stat.gauge >= 100.0
func set_gauge(new_gauge:float)->void:
	stat.gauge = new_gauge

func start_turn()->void:
	is_turn = true
	animation.play("Idle")
func damaged(atk:int) -> void:
	stat.health -= atk-stat.def
	if stat.health == 0:
		pass
	animation.play("Hurt")
	var damage_num = damage_display.instantiate()
	damage_num.set_values(atk-stat.def,position)
	add_child(damage_num)
func return_to_idle():
	animation.play("Idle")
func end_turn()->void:
	stat.gauge = 0
	is_turn = false
	animation.play("Idle")
	animation.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	pass
