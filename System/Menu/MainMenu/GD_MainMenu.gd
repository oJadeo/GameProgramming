extends Control


func _on_play_pressed():
	var next_scene = load("res://System/Menu/LevelSelect/GD_LevelSelect.tscn").instantiate()
	add_child(next_scene)
	#get_tree().change_scene_to_packed(next_scene)


func _on_quit_pressed():
	get_tree().quit()
