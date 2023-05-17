extends Node

func change_scene(scene_path):
	var next_scene = load(scene_path).instantiate()
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
