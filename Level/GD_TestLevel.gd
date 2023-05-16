extends Node2D
class_name LEVEL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win_level()-> void:
	GlobalSave.unlock_level(PlayerVar.selectedLevel+1)
	$CanvasLayer/VictoryOverlay.visible = true
	$CanvasLayer/VictoryOverlay.update()

func lose_level() -> void:
	$CanvasLayer/DefeatOverlay.visible = true

