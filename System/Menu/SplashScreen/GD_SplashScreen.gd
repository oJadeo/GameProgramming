extends Control

func _on_reference_rect_gui_input(event):
	if event.is_action_pressed("select"):
		Util.change_scene("res://System/Menu/MainMenu/GD_MainMenu.tscn")
		queue_free()
