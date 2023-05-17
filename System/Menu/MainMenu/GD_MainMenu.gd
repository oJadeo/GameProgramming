extends Control

func _ready():
	if not GlobalSave.get_played_tutorial():
		$Continue.text = "New Game"
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
	if not GlobalSave.get_played_tutorial():
		GlobalSave.played_tutorial()
		$AnimationPlayer.play("fade_out")
		await $AnimationPlayer.animation_finished
		
		Util.change_scene("res://System/Menu/TutorialSelect/GD_TutorialSelect.tscn")
		###Change this to beginning of tutorial
		
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
