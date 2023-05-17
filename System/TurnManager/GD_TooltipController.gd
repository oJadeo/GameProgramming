extends VBoxContainer

var _formation_tooltip = load("res://System/TurnManager/S_FormationTooltip.tscn")
var _health_tooltip = load("res://System/TurnManager/S_HealthTooltip.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func new_formation_tooltip(_btn, _name, _description):
	var _tooltip = _formation_tooltip.instantiate()
	add_child(_tooltip)

	_tooltip.set_tooltip_desc(_name, _description)

	var _tooltip_num: int = get_child_count() - 1
	_btn.mouse_entered.connect(tooltip_show.bind(_tooltip_num))
	_btn.mouse_exited.connect(tooltip_hide)
	_tooltip.visible = false

func new_health_tooltip(_character):
	var _tooltip = _health_tooltip.instantiate()
	add_child(_tooltip)

	_tooltip.connect_character(_character)

	var _tooltip_num: int = get_child_count() - 1
	_character.on_character_hover_enter.connect(tooltip_show.bind(_tooltip_num))
	_character.on_character_hover_exited.connect(tooltip_hide)
	_tooltip.visible = false

func tooltip_show(_num: int) -> void:
	tooltip_hide()
	var _tooltips = get_children()
	_tooltips[_num].set_showing(true)
	pass

func tooltip_hide() -> void:
	var _tooltips = get_children()
	for i in _tooltips:
		i.set_showing(false)
