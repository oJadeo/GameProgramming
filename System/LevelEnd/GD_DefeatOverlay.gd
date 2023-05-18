extends Control

func _on_restart_level_pressed():
	Board.clear_board()
	Util.change_scene("res://Level/S_TestLevel.tscn")
	get_parent().get_parent().queue_free()

func _on_reselect_characters_pressed():
	Board.clear_board()
	Util.change_scene("res://System/Menu/TeamSelect/GD_TeamSelect.tscn")
	get_parent().get_parent().queue_free()

func _on_main_menu_pressed():
	Board.clear_board()
	Util.change_scene("res://System/Menu/MainMenu/GD_MainMenu.tscn")
	get_parent().get_parent().queue_free()
