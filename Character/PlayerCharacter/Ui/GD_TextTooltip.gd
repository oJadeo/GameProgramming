extends VBoxContainer
class_name TextTooltip

@onready var header_label: Label = $Top/HeaderLabel
@onready var description_label: Label = $Description/Label
@onready var cooldown_label: Label = $Cooldown/CooldownLabel
@onready var status_label: Label = $Cooldown/StatusLabel
@onready var top_bg: Sprite2D = $Top/TopBackground
@onready var description_bg: Panel = $Description
@onready var cooldown_bg: Panel = $Cooldown

@export var ready_color: Color
@export var not_ready_color: Color
@export var outline_color: Color
@export var background_color: Color
@export var text_color: Color
@export_range(0, 1) var transparent: float:
	set(value):
		set_tooltip_text_color(
			Color(
				text_color.r,
				text_color.g,
				text_color.b,
				text_color.a * value,
			)
		)
		set_tooltip_background_color(
			Color(
				background_color.r,
				background_color.g,
				background_color.b,
				background_color.a * value,
			)
		)
		set_tooltip_outline_color(
			Color(
				outline_color.r,
				outline_color.g,
				outline_color.b,
				outline_color.a * value,
			)
		)
		if cooldown <= 0:
			set_tooltip_top_background_color(
				Color(
					ready_color.r,
					ready_color.g,
					ready_color.b,
					ready_color.a * value,
				),
			)
		else:
			set_tooltip_top_background_color(
				Color(
					not_ready_color.r,
					not_ready_color.g,
					not_ready_color.b,
					not_ready_color.a * value,
				),
			)

var last_state = false
var max_cooldown:int = 0
var cooldown:int = 0:
	set(value):
		if value <= 0:
			set_tooltip_top_background_color(
				Color(
					ready_color.r,
					ready_color.g,
					ready_color.b,
					ready_color.a * transparent,
				),
			)
		else:
			set_tooltip_top_background_color(
				Color(
					not_ready_color.r,
					not_ready_color.g,
					not_ready_color.b,
					not_ready_color.a * transparent,
				),
			)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_tooltip_max_cooldown(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_tooltip_text_color(_color: Color):
	if header_label:
		header_label.add_theme_color_override("font_color", _color)
	if description_label:
		description_label.add_theme_color_override("font_color", _color)
	if cooldown_label:
		cooldown_label.add_theme_color_override("font_color", _color)
	if status_label:
		status_label.add_theme_color_override("font_color", _color)
	
func set_tooltip_top_background_color(_color: Color):
	if top_bg:
		top_bg.material.set_shader_parameter(
			"BG_COLOR", 
			_color,
		)
	
func set_tooltip_outline_color(_color: Color):
	if top_bg:
		top_bg.material.set_shader_parameter(
			"OUTLINE_COLOR",
			_color,
		)
	if description_bg:
		description_bg.get_theme_stylebox("panel").set_border_color(_color)
	if cooldown_bg:
		cooldown_bg.get_theme_stylebox("panel").set_border_color(_color)

func set_tooltip_background_color(_color: Color):
	if description_bg:
		description_bg.get_theme_stylebox("panel").set_bg_color(_color)
	if cooldown_bg:
		cooldown_bg.get_theme_stylebox("panel").set_bg_color(_color)

func set_tooltip_desc(header:String, description:String) -> void:
	if header_label:
		header_label.text = header
	if description_label:
		description_label.text = description

func set_tooltip_max_cooldown(_max_cooldown:int) -> void:
	max_cooldown = _max_cooldown
	cooldown = 0
	if _max_cooldown == 0:
		cooldown_bg.visible = false
	else:
		cooldown_bg.visible = true
		cooldown_label.text = "Cooldown: " + str(_max_cooldown)
		status_label.text = "Status: Ready"

func set_tooltip_cooldown(_cooldown:int):
	cooldown = _cooldown
	if _cooldown == 0:
		status_label.text = "Status: Ready"
	else:
		status_label.text = "Status: Not Ready (" + \
			str(max_cooldown - _cooldown) + \
			"/" + str(max_cooldown) + ")"

func set_showing(_value: bool):
	if _value:
		$AnimationPlayer.play('fade_in')
	else:
		if last_state:
			self.visible = false
	last_state = _value
