extends Control
class_name TextTooltip

@onready var header_label: Label = $Top/TopBackground/HeaderLabel
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

var max_cooldown:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	top_bg.material.set_shader_parameter(
		"BG_COLOR", 
		ready_color,
	)
	set_tooltip_max_cooldown(3)
	set_tooltip_cooldown(2)
	set_tooltip_outline_color(outline_color)
	set_tooltip_background_color(background_color)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_tooltip_outline_color(_color: Color):
	top_bg.material.set_shader_parameter(
		"OUTLINE_COLOR",
		_color,
	)
	description_bg.get_theme_stylebox("panel").set_border_color(_color)
	cooldown_bg.get_theme_stylebox("panel").set_border_color(_color)
	pass

func set_tooltip_background_color(_color: Color):
	description_bg.get_theme_stylebox("panel").set_bg_color(_color)
	cooldown_bg.get_theme_stylebox("panel").set_bg_color(_color)

func set_tooltip_desc(header:String, description:String) -> void:
	header_label.text = header
	description_label.text = description

func set_tooltip_max_cooldown(_max_cooldown:int) -> void:
	max_cooldown = _max_cooldown
	top_bg.material.set_shader_parameter(
		"BG_COLOR", 
		ready_color,
	)
	if _max_cooldown == 0:
		cooldown_bg.visible = false
	else:
		cooldown_bg.visible = true
		
		cooldown_label.text = "Cooldown: " + str(_max_cooldown)
		status_label.text = "Status: Ready"

func set_tooltip_cooldown(_cooldown:int):
	if _cooldown == 0:
		top_bg.material.set_shader_parameter(
			"BG_COLOR", 
			ready_color,
		)
		status_label.text = "Status: Ready"
	else:
		top_bg.material.set_shader_parameter(
			"BG_COLOR", 
			not_ready_color,
		)
		status_label.text = "Status: Not Ready (" + \
			str(max_cooldown - _cooldown) + \
			"/" + str(max_cooldown) + ")"
