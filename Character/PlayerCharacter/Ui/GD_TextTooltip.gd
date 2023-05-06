extends Control

@onready var header_label = $Container/Top/Panel/Label
@onready var description_label = $Container/Description/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_tooltip_desc(header:String, description:String) -> void:
	header_label.text = header
	description_label.text = description

