extends VBoxContainer

var text_tooltip = load("res://Character/PlayerCharacter/Ui/S_TextTooltip.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	new_text_tooltip("test", "test", "test")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_text_tooltip(name: String, header: String, description: String) -> Resource:
	var _tooltip = text_tooltip.instantiate()
	_tooltip.name = name
	_tooltip.set_tooltip_desc(header, description)
	add_child(_tooltip)
	
	return _tooltip
