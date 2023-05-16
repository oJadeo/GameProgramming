extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for level in $LevelButton.get_children():
		level.text = "Level " + level.name
		var iName = level.name.to_int()
		if iName in GlobalSave.get_unlock_level():
			level.disabled = false
			level.connect('pressed',change_level.bind(iName))
		else:
			level.disabled = true

func change_level(level_name:int):
	var next_scene = load("res://System/Menu/TeamSelect/GD_TeamSelect.tscn").instantiate()
	PlayerVar.selectedLevel = level_name
	#PlayerVar.charDataList = [null,null,null]
	get_tree().get_root().add_child(next_scene)
	queue_free()

func _on_back_pressed():
	Util.change_scene("res://System/Menu/MainMenu/GD_MainMenu.tscn")
	queue_free()
