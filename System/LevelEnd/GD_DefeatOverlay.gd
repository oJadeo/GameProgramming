extends Control

func _on_restart_level_pressed():
	Board.clear_board()
	get_tree().change_scene_to_file("res://Level/S_TestLevel.tscn")

func _on_reselect_characters_pressed():
	get_tree().change_scene_to_file("res://System/Menu/TeamSelect/GD_TeamSelect.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://System/Menu/MainMenu/GD_MainMenu.tscn")
