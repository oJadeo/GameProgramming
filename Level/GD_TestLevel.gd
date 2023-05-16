extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win_level()-> void:
	$CanvasLayer/VictoryOverlay.visible = true
	$CanvasLayer/VictoryOverlay.update()

func lose_level() -> void:
	pass

