extends Control

@onready var header_label = $Container/Top/Panel/Label
@onready var description_label = $Container/Description/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_move() -> void:
	header_label.text = "Move"
	description_label.text = "Move 1-2 spaces"

func set_end_turn() -> void:
	header_label.text = "End turn"
	description_label.text = "End the turn"
