extends HBoxContainer

@export var reward_name:String
@export var reward_exp:int
@export var icon_c:Resource
@export var icon_i:Resource
@export var e_vis:bool #check from int val instead
@export var c_vis:bool
@export var i_vis:bool

@onready var reward_name_val = $TextureRect/Label
@onready var reward_exp_val = $TextureRect/BoxContainer/EXPValue
@onready var icon_c_val = $TextureRect/BoxContainer/Sprite2D
@onready var icon_i_val = $TextureRect/BoxContainer/itemIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	reward_name_val.text = reward_name
	reward_exp_val.text = str(reward_exp)
	icon_c_val.texture = icon_c
	icon_i_val.texture = icon_i

	reward_exp_val.visible = e_vis
	icon_c_val.visible = c_vis
	icon_i_val.visible = i_vis
