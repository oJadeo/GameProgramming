extends HBoxContainer

@export var char_name:String
@export var hp:int
@export var atk:int
@export var def:int
@export var spd:int

@export var hp_up:bool
@export var atk_up:bool
@export var def_up:bool
@export var spd_up:bool

@export var char_id:String
@export var skill_id_1:String
@export var skill_id_2:String

@onready var char_name_val = $TextureRect/Stats/Name/Value
@onready var hp_val = $"TextureRect/Stats/HBox_HP-ATK/HP/Value"
@onready var atk_val = $"TextureRect/Stats/HBox_HP-ATK/Attack/Value"
@onready var def_val = $"TextureRect/Stats/HBox_DEF-SPD/Defence/Value"
@onready var spd_val = $"TextureRect/Stats/HBox_DEF-SPD/Speed/Value"
@onready var skill_icon_1_val = $TextureRect/Stats/VBox_skill/skillIcon1
@onready var skill_icon_2_val = $TextureRect/Stats/VBox_skill/skillIcon2

@onready var hp_up_val = $"TextureRect/Stats/HBox_HP-ATK/HP/upAlert"
@onready var atk_up_val = $"TextureRect/Stats/HBox_HP-ATK/Attack/upAlert"
@onready var def_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Defence/upAlert"
@onready var spd_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Speed/upAlert"
@onready var skill_up_val = $TextureRect/Stats/VBox_skill

# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	char_name_val.text = char_name
	hp_val.text = str(hp)
	atk_val.text = str(atk)
	def_val.text = str(def)
	spd_val.text = str(spd)
	var hp_up_color = Color8(0,215,60,255) if hp_up else Color8(0,0,0,0)
	hp_up_val.add_theme_color_override("font_color", hp_up_color)
	var atk_up_color = Color8(0,215,60,255) if atk_up else Color8(0,0,0,0)
	atk_up_val.add_theme_color_override("font_color", atk_up_color)
	var def_up_color = Color8(0,215,60,255) if def_up else Color8(0,0,0,0)
	def_up_val.add_theme_color_override("font_color", def_up_color)
	var spd_up_color = Color8(0,215,60,255) if spd_up else Color8(0,0,0,0)
	spd_up_val.add_theme_color_override("font_color", spd_up_color)
	
	if not skill_id_1.is_empty():
		skill_icon_1_val.texture = load("res://Assets/" + char_id + "/" + char_id + "_" + skill_id_1 + ".png")
		skill_up_val.visible = true
		skill_icon_1_val.visible = true
		if not skill_id_2.is_empty():
			skill_icon_2_val.texture = load("res://Assets/" + char_id + "/" + char_id + "_" + skill_id_2 + ".png")
			skill_icon_2_val.visible = true
