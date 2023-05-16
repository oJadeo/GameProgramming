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

#@onready var hp_up_val = $"TextureRect/Stats/HBox_HP-ATK/HP/upAlert"
#@onready var atk_up_val = $"TextureRect/Stats/HBox_HP-ATK/Attack/upAlert"
#@onready var def_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Defence/upAlert"
#@onready var spd_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Speed/upAlert"
@onready var hp_up_val = $"TextureRect/Stats/HBox_HP-ATK/HP/RichTextLabel"
@onready var atk_up_val = $"TextureRect/Stats/HBox_HP-ATK/Attack/RichTextLabel"
@onready var def_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Defence/RichTextLabel"
@onready var spd_up_val = $"TextureRect/Stats/HBox_DEF-SPD/Speed/RichTextLabel"
@onready var skill_up_val = $TextureRect/Stats/VBox_skill

@onready var sprite_path = "TextureRect/CharacterIcon/Sprite2D_"+char_id
@onready var sprite = get_node(sprite_path)
@onready var ani = $TextureRect/CharacterIcon/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	char_name_val.text = char_name
	sprite.visible = true
	ani.play("idle")
	hp_val.text = str(hp)
	atk_val.text = str(atk)
	def_val.text = str(def)
	spd_val.text = str(spd)
	if not hp_up:
		#hp_up_val.add_theme_color_override("font_color", Color8(0,0,0,0))
		hp_up_val.add_theme_color_override("default_color", Color8(0,0,0,0))
	if not atk_up:
		#atk_up_val.add_theme_color_override("font_color", Color8(0,0,0,0))
		atk_up_val.add_theme_color_override("default_color", Color8(0,0,0,0))
	if not def_up:
		#def_up_val.add_theme_color_override("font_color", Color8(0,0,0,0))
		def_up_val.add_theme_color_override("default_color", Color8(0,0,0,0))
	if not spd_up:
		#spd_up_val.add_theme_color_override("font_color", Color8(0,0,0,0))
		spd_up_val.add_theme_color_override("default_color", Color8(0,0,0,0))
	
	if not skill_id_1.is_empty():
		skill_icon_1_val.texture = load("res://Assets/" + char_id + "/" + char_id + "_" + skill_id_1 + ".png")
		skill_up_val.visible = true
		skill_icon_1_val.visible = true
		if not skill_id_2.is_empty():
			skill_icon_2_val.texture = load("res://Assets/" + char_id + "/" + char_id + "_" + skill_id_2 + ".png")
			skill_icon_2_val.visible = true
