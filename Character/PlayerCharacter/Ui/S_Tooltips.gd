extends VBoxContainer

var text_tooltip = load("res://Character/PlayerCharacter/Ui/S_TextTooltip.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	new_text_tooltip("Move", "Move", "Move 1-2 spaces")
	new_text_tooltip("Basic_atk", "Move", "Move 1-2 spaces")
	new_text_tooltip("Skill_1", "Move", "Move 1-2 spaces")
	new_text_tooltip("Skill_2", "Move", "Move 1-2 spaces")
	new_text_tooltip("EndTurn", "End turn", "End this turn")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_text_tooltip(name: String, header: String, description: String) -> TextTooltip:
	var _tooltip = text_tooltip.instantiate()
	_tooltip.name = name
	add_child(_tooltip)
	_tooltip.set_tooltip_desc(header, description)
	
	return _tooltip
