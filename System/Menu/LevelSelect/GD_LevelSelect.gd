extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for hbox in $VBoxContainer.get_children():
		for level in hbox.get_children():
			if level.name in PlayerVar.unlockedLevels:
				level.disabled = false
				level.connect('pressed',change_level.bind(level.name))
			else:
				level.disabled = true
	pass # Replace with function body.

func change_level(level_name:String):
	var next_scene = load("res://System/Menu/TeamSelect/GD_TeamSelect.tscn").instantiate()
	next_scene.set_stage(level_name)
	add_sibling(next_scene)
	queue_free()


func _on_back_pressed():
	var next_scene = load("res://System/Menu/MainMenu/GD_MainMenu.tscn")
	get_tree().change_scene_to_packed(next_scene)
