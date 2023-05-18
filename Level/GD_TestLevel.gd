extends Node2D
class_name LEVEL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bg = $TextureRect
	match PlayerVar.selectedLevel:
		1,2:
			bg.texture = load("res://Assets/test_bg.png")
		3,4:
			bg.texture = load("res://Assets/bg2.png")
		5,6:
			bg.texture = load("res://Assets/bg3.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stop_level():
	var manager = $S_turn_manager
	manager.stop_level()

func win_level()-> void:
	# Disable ui TODO STOP
	stop_level()
	GlobalSave.unlock_level(PlayerVar.selectedLevel+1)
	$CanvasLayer/VictoryOverlay.visible = true
	$CanvasLayer/VictoryOverlay.update()

func lose_level() -> void:
	#  TODO STOP
	stop_level()
	$CanvasLayer/DefeatOverlay.visible = true

