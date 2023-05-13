extends CanvasLayer

@export var title:String = ""
@export_multiline var description:String = ""

@onready var title_label = $EndTurn/Container/Top/Label
@onready var description_label = $EndTurn/Container/Description/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	title_label.text = title
	description_label.text = description


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_close_pressed():
	visible = false
