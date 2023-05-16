extends Node2D

var select_level:int

var order:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win_level()-> void:
	pass

func lose_level() -> void:
	pass
	

func _on_s_shuriken_finish_tutorial():
	
	var next_scene = load("res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn").instantiate()
	get_tree().get_root().add_child(next_scene)
	queue_free()
	Board.clear_board()


func _on_s_tutorial_turn_manager_start_turn():
	match order:
		1:
			$CanvasLayer.visible = true
			order += 1
		2:
			$CanvasLayer2.visible = true
			order += 1
		3:
			print("fail")
