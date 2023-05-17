extends Control

var toTutorial = false
func _ready():
	if len(GlobalSave.get_unlock_level()) == 0 or GlobalSave.get_unlock_level()[-1] == 1:
		$Continue.text = "New Game"
		toTutorial = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	
func _on_quit_pressed():
	get_tree().quit()

func _on_level_select_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")
	queue_free()

func _on_continue_pressed():
	var next_scene
	if toTutorial:
		$AnimationPlayer.play("fade_out")
		await $AnimationPlayer.animation_finished
		Util.change_scene("res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn")
		queue_free()
	else:
		var last_level_name = GlobalSave.get_unlock_level()[-1]
		next_scene = load("res://System/Menu/TeamSelect/GD_TeamSelect.tscn").instantiate()
		PlayerVar.selectedLevel = last_level_name
		$AnimationPlayer.play("fade_out")
		await $AnimationPlayer.animation_finished
		get_tree().get_root().add_child(next_scene)
		queue_free()


func _on_tutorial_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn")
	queue_free()
