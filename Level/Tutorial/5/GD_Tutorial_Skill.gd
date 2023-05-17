extends Node2D

var select_level:int
var order = 0

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
	

func _on_s_tutorial_move_turn_manager_finish_tutorial():
	
	match order:
		0:
			$CanvasLayer2.visible = true
			order += 1
			var player = $S_tutorial_move_turn_manager/PlayerManager/Characters/S_PC2
			var control = player.get_node("CanvasLayer/ControlButton")
			control.visible = true
		1:
			var next_scene = "res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn" if GlobalSave.get_played_tutorial() \
						else "res://Level/Tutorial/6/S_Tutorial_Formation.tscn"
			
			Board.clear_board()
			Util.change_scene(next_scene)
			queue_free()
