extends Control

func _on_quit_pressed():
	get_tree().quit()


func _on_level_select_pressed():
	get_tree().change_scene_to_file("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")

func _on_continue_pressed():
	var last_level_name = PlayerVar.unlockedLevels[-1]
	var next_scene = load("res://System/Menu/TeamSelect/GD_TeamSelect.tscn").instantiate()
	next_scene.set_stage(last_level_name)
	get_tree().get_root().add_child(next_scene)
	queue_free()
