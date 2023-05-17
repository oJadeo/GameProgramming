extends Control

func _ready():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	
func _on_reference_rect_gui_input(event):
	if event.is_action_pressed("select"):
		$AnimationPlayer.play("fade_out")
		await $AnimationPlayer.animation_finished
		Util.change_scene("res://System/Menu/MainMenu/GD_MainMenu.tscn")
		queue_free()
		
