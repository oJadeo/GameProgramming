extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSave.change_character_level(1,3)
	GlobalSave.print_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
