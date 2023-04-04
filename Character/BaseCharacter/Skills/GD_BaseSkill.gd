extends Node2D
class_name BaseSkills

enum GET_TILE{
	empty,
	unit,
	all
}
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	pass
	
func init(_player:Character)-> void:
	player = _player

func select_target(cood:Vector2) -> void:
	pass

func finish_skill() -> void:
	pass

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
