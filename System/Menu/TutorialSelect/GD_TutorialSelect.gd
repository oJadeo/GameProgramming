extends Control

var tutorial_scene = ['','/S_Tutorial_Move.tscn','/S_Tutorial_Basic.tscn','/S_Tutorial_End.tscn','/S_Tutorial_Backstab.tscn','/S_Tutorial_Skill.tscn','/S_Tutorial_Formation.tscn']



# Called when the node enters the scene tree for the first time.
func _ready():
	for tutorial in $TutorialButton.get_children():
		tutorial.text = "Tutorial " + tutorial.name
		var iName = tutorial.name.to_int()
		tutorial.connect('pressed',change_level.bind(iName))

func change_level(tutorial_name:int):
	var next_scene = load("res://Level/Tutorial/"+str(tutorial_name)+tutorial_scene[tutorial_name]).instantiate()
	get_tree().get_root().add_child(next_scene)
	queue_free()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://System/Menu/MainMenu/GD_MainMenu.tscn")
