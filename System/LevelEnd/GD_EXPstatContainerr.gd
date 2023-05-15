extends HBoxContainer

@export var char_name:String
@export var icon:Resource
@export var lvl:int
@export var c_exp:int
@export var g_exp:int
@export var lvl_up:bool

@onready var char_name_val = $TextureRect/Stats/Name/Value
@onready var icon_val = $TextureRect/CharacterIcon/Icon
@onready var lvl_val = $TextureRect/Stats/LevelBox/Level/Value
@onready var c_exp_val = $TextureRect/Stats/EXPBar/ProgressBarContainer/EXPLabelContainer/EXPLabel
@onready var g_exp_val = $TextureRect/Stats/EXPBar/ProgressBarContainer/EXPLabelContainer/GoalEXPLabel
@onready var lvl_up_val = $TextureRect/Stats/LevelBox/LevelUpAlert

# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	char_name_val.text = char_name
	icon_val.texture = icon
	lvl_val.text = str(lvl)
	c_exp_val.text = str(c_exp)
	g_exp_val.text = str(g_exp)
	if not lvl_up:
		lvl_up_val.add_theme_color_override("font_color", Color8(0,0,0,0))
