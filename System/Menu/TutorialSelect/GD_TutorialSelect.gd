extends Control

var tutorial_scene = ['','/S_Tutorial_Move.tscn','/S_Tutorial_Basic.tscn','/S_Tutorial_End.tscn','/S_Tutorial_Backstab.tscn','/S_Tutorial_Skill.tscn','/S_Tutorial_Formation.tscn']



# Called when the node enters the scene tree for the first time.
func _ready():
	for tutorial in $TutorialButton.get_children():
		tutorial.text = "Tutorial " + tutorial.name
		var iName = tutorial.name.to_int()
		tutorial.connect('pressed',change_level.bind(iName))
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func change_level(tutorial_name:int):
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://Level/Tutorial/"+str(tutorial_name)+tutorial_scene[tutorial_name])
	queue_free()

func _on_back_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://System/Menu/MainMenu/GD_MainMenu.tscn")
	queue_free()
