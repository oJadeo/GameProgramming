extends Node2D
class_name Character



enum EFFECT{
	buff,
	debuff
}
var stat = Status.new()

@export var start_atk:int = 1
@export var start_def:int = 1
@export var start_speed:int = 10
@export var start_max_health:int = 10


var skill_list
var damage_display = preload("res://System/Damage/S_DamageNuber.tscn")
var heal_display = preload("res://System/Heal/S_HealNumber.tscn")
var move_range:int = 2
@export var start_direction:Vector2 = Vector2(1,0)
var direction:Vector2 = Vector2(1,0):
	set(new_value):
		direction = new_value
		sprite.flip_h = direction != Vector2(1,0)
@export var start_cood:Vector2 = Vector2(-1,-1)
var board_cood:Vector2 = Vector2(-1,-1):
	set(new_value):
		Board.change_cood(self,new_value)
		board_cood = new_value

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var move_timer = $MoveTimer
@onready var manager = get_parent().get_parent()
var selecting_move:BaseSkills
var is_move:bool
var is_turn:bool = false
var is_target:bool = false
var status_effect:Array
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	if start_cood == Vector2(-1,-1):
		return
	board_cood = start_cood
	stat.death.connect(dealth)
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
	
	for skill in skill_list:
		if skill.cooldown != 0:
			skill.cooldown -= 1
			
func damaged(atk:int,attack_direction:Vector2) -> void:
	var damage:int = atk-stat.def if direction.dot(attack_direction) == -1 else (atk-stat.def)*1.5
	stat.health = stat.health -damage
	if stat.health == 0:
		pass
	animation.play("Hurt")
	var damage_num = damage_display.instantiate()
	add_child(damage_num)
	damage_num.set_values(damage)
func healed(amount:int) -> void:
	stat.health += amount
	var heal_num = heal_display.instantiate()
	add_child(heal_num)
	heal_num.set_values(amount)
func return_to_idle():
	animation.play("Idle")
	animation.stop()
func finish_walk()->void:
	pass

func trigger() -> void:
	selecting_move.trigger()
func turn_effect(type:EFFECT,buff_stat:Status,turn:int) -> void:
	match type:
		EFFECT.buff:
			stat.atk += buff_stat.atk 
			stat.def += buff_stat.def 
			stat.speed += buff_stat.speed 
			stat.gauge += buff_stat.gauge 
			status_effect.append([turn,type,buff_stat])
		EFFECT.debuff:
			stat.atk -= buff_stat.atk 
			stat.def -= buff_stat.def 
			stat.speed -= buff_stat.speed 
			stat.gauge -= buff_stat.gauge 
			status_effect.append([turn,type,buff_stat])
func resolve(effect)-> void:
	match effect[1]:
		EFFECT.buff:
			stat.atk -= effect[2].atk 
			stat.def -= effect[2].def 
			stat.speed -= effect[2].speed 
		EFFECT.debuff:
			stat.atk += effect[2].atk 
			stat.def += effect[2].def 
			stat.speed += effect[2].speed 
func end_turn()->void:
	stat.gauge = 0
	
	for effect in status_effect:
		effect[0] -= 1
		if effect[0] == 0:
			resolve(effect)
	
	is_turn = false
	selecting_move = null
	animation.play("Idle")
	animation.stop()
func dealth():
	animation.play("death")
	
func _process(delta: float) -> void:
	pass
