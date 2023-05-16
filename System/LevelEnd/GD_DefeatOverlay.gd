extends Control

func _on_restart_level_pressed():
	Board.clear_board()
	var next_scene = load("res://Level/S_TestLevel.tscn").instantiate()
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
	queue_free()


func _on_reselect_characters_pressed():
	var next_scene = load("res://System/Menu/TeamSelect/GD_TeamSelect.tscn").instantiate()
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
	queue_free()


func _on_main_menu_pressed():
	var next_scene = load("res://System/Menu/MainMenu/GD_MainMenu.tscn").instantiate()
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
	queue_free()
