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
	
func _on_s_move_tutorial_finish_tutorial():
	var next_scene = "res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn" if GlobalSave.get_played_tutorial() \
				else "res://Level/Tutorial/2/S_Tutorial_Basic.tscn"
	
	Board.clear_board()
	Util.change_scene(next_scene)
	queue_free()

func _on_s_tutorial_move_turn_manager_start_turn():
	$CanvasLayer.visible = true
