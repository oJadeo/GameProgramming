extends Node2D

var select_level:int


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
	
func _on_s_formation_3_finish_tutorial():
	if GlobalSave.get_played_tutorial():
		Util.change_scene("res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn")
	
		Board.clear_board()
		queue_free()
	else:
		GlobalSave.played_tutorial()
		PlayerVar.selectedLevel = 1
		Util.change_scene("res://System/Menu/TeamSelect/GD_TeamSelect.tscn")
		Board.clear_board()
		queue_free()


func _on_s_tutorial_turn_manager_start_turn():
	$CanvasLayer.visible = true
