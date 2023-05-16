@tool
extends VBoxContainer
class_name FormationTooltip

@onready var top: Panel = $Top
@onready var description: Panel = $Description
@onready var helper: Panel = $Helper

@onready var top_label: Label = $Top/Label
@onready var description_label: Label = $Description/Label

@onready var helper_items: VBoxContainer = $Helper/ItemContainer

@export_category("Tooltip Options")
@export var top_background_color: Color:
	set(value):
		top_background_color = value
		set_tooltip_top_background_color(value)
@export var header_text: String:
	set(value):
		header_text = value
		set_tooltip_header_text(value)
@export_multiline var description_text: String:
	set(value):
		description_text = value
		set_tooltip_description_text(value)
@export_range(0, 1) var transparent: float:
	set(value):
		transparent = value
		set_transparency(value)
@export_range(0, 1) var default_background_transparent: float:
	set(value):
		default_background_transparent = value
		set_transparency(transparent)

var last_visible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_tooltip_desc(_header: String, _description: String):
	header_text = _header
	description_text = _description

func set_tooltip_top_background_color(_color: Color):
	if top:
		var _new_color: Color = _color
		_new_color.a = transparent * default_background_transparent
		top.get_theme_stylebox("panel").set_bg_color(_new_color)

func set_tooltip_header_text(_value: String):
	if top_label:
		top_label.text = _value

func set_tooltip_description_text(_value: String):
	if description_label:
		description_label.text = _value

func set_transparency(_value: float):
	set_tooltip_top_background_color(top_background_color)

	if top:
		var _sb_top: StyleBoxFlat = top.get_theme_stylebox("panel")

		var _bd_color: Color = _sb_top.border_color
		_bd_color.a = _value * default_background_transparent
		_sb_top.border_color = _bd_color

	if description:
		var _sb_description: StyleBoxFlat = description.get_theme_stylebox("panel")

		var _bg_color: Color = _sb_description.bg_color
		_bg_color.a = _value * default_background_transparent
		_sb_description.bg_color = _bg_color

		var _bd_color: Color = _sb_description.border_color
		_bd_color.a = _value * default_background_transparent
		_sb_description.border_color = _bd_color

	if helper:
		var _sb_helper: StyleBoxFlat = helper.get_theme_stylebox("panel")

		var _bg_color: Color = _sb_helper.bg_color
		_bg_color.a = _value * default_background_transparent
		_sb_helper.bg_color = _bg_color

		var _bd_color: Color = _sb_helper.border_color
		_bd_color.a = _value * default_background_transparent
		_sb_helper.border_color = _bd_color
	
	if top_label:
		var _font_color = top_label.get_theme_color("font_color")
		_font_color.a = _value
		top_label.add_theme_color_override("font_color", _font_color)
	
	if description_label:
		var _font_color = description_label.get_theme_color("font_color")
		_font_color.a = _value
		description_label.add_theme_color_override("font_color", _font_color)

	if helper_items:
		var _helpers = helper_items.get_children()
		for _item in _helpers:
			var _color_panel: Panel = _item.get_child(0).get_child(0)

			var _sb_color_panel: StyleBoxFlat = _color_panel.get_theme_stylebox("panel")
			var _bg_color: Color = _sb_color_panel.bg_color
			_bg_color.a = _value
			_sb_color_panel.bg_color = _bg_color
			var _bd_color: Color = _sb_color_panel.border_color
			_bd_color.a = _value
			_sb_color_panel.border_color = _bd_color

			var _label: Label = _item.get_child(1)
			var _font_color = _label.get_theme_color("font_color")
			_font_color.a = _value
			_label.add_theme_color_override("font_color", _font_color)
			
func set_showing(_value: bool):
	if _value:
		if not last_visible:
			$AnimationPlayer.play("fade_in")
	else:
		visible = false
	last_visible = _value
