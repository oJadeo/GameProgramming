extends Node2D

@onready var label:Label = $LabelContainer/DamageLabel
@onready var timer = $Timer
@export var height:int =1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_position(Vector2(0,- 40))
	timer.start()

func set_values(value:int)->void:
	label.text = str(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= height*delta

func _on_timer_timeout() -> void:
	queue_free()
