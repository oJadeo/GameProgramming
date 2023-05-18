@tool
extends Panel

@onready var stats_container = $MarginContainer/StatsContainer

@export_category("Color Override")
@export var border_color: Color:
	set(value):
		border_color = value
		set_tooltip_border_color(value)
@export var background_color: Color:
	set(value):
		background_color = value
		set_tooltip_background_color(value)
@export_range(0, 1) var transparent: float:
	set(value):
		transparent = value
		set_tooltip_border_color(border_color)
		set_tooltip_background_color(background_color)
@export_range(0, 1) var default_transparent: float:
	set(value):
		default_transparent = value
		set_tooltip_border_color(border_color)
		set_tooltip_background_color(background_color)
@export var progress_color: Color:
	set(value):
		progress_color = value
		if stats_container:
			stats_container.progress_color = value

var last_visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func connect_character(_character):
	$MarginContainer/StatsContainer.connect_character(_character)

func set_tooltip_border_color(_color: Color):
	get_theme_stylebox("panel").border_color = Color(
		_color.r,
		_color.g,
		_color.b,
		transparent * default_transparent,
	)

func set_tooltip_background_color(_color: Color):
	get_theme_stylebox("panel").bg_color = Color(
		_color.r,
		_color.g,
		_color.b,
		transparent * default_transparent,
	)

func set_showing(_value: bool):
	if _value:
		visible = true
		if not last_visible:
			$AnimationPlayer.play("fade_in")
	else:
		visible = false
	last_visible = _value
