extends Control

func _on_reference_rect_gui_input(event):
	if event.is_action_pressed("select"):
		get_tree().change_scene_to_file("res://System/Menu/MainMenu/GD_MainMenu.tscn")
