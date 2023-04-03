extends Node2D

@onready var label:Label = $LabelContainer/DamageLabel
@onready var timer = $Timer
@export var height:int =5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_values(value:int,start_pos:Vector2)->void:
	label.text = str(value)

func start()->void:
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += height*delta

func _on_timer_timeout() -> void:
	queue_free()
