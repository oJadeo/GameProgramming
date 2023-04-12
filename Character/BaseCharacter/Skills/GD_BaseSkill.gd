extends Node2D
class_name BaseSkills

enum GET_TILE{
	empty,
	unit,
	all
}
@export var skill_name:String
var player:Character
var cooldown:int = 0
@export var max_cooldown:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	pass
	
func init(_player:Character)-> void:
	player = _player

func select_target(cood:Vector2) -> void:
	pass

func check_target()->bool:
	return false

func finish_skill() -> void:
	cooldown = max_cooldown

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
