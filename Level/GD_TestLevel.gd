extends Node2D
class_name LEVEL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bg = $TextureRect
	match PlayerVar.selectedLevel:
		1,2:
			$TextureRect.visible = true
			
		3,4:
			$TextureRect2.visible = true
		5,6:
			$TextureRect3.visible = true
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

