extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for tutorial in $TutorialButton.get_children():
		tutorial.text = "Tutorial " + tutorial.name
		var iName = tutorial.name.to_int()
		tutorial.connect('pressed',change_level.bind(iName))

func change_level(tutorial_name:int):
	var next_scene = load("res://Level/Tutorial/"+str(tutorial_name)+"/S_Tutorial_Move.tscn").instantiate()
	get_tree().get_root().add_child(next_scene)
	queue_free()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://System/Menu/MainMenu/GD_MainMenu.tscn")
