extends Node2D

var select_level:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func finish_level(victory:bool)-> void:
	pass

func _on_s_tutorial_move_turn_manager_finish_tutorial():
	print("Finish Endturn tutorial")
