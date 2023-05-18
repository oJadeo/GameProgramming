extends HBoxContainer

@export var reward_name:String
@export var reward_exp:int
@export var char_id:String
@export var charm_id:String

@onready var reward_name_val = $TextureRect/Label
@onready var reward_exp_val = $TextureRect/BoxContainer/EXPValue
@onready var char_val = $TextureRect/BoxContainer/Icon
@onready var charm_val = $TextureRect/BoxContainer/itemIcon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_display():
	reward_name_val.text = reward_name
	if reward_exp != 0:
		reward_exp_val.text = str(reward_exp)
		reward_exp_val.visible = true
	elif not char_id.is_empty():
		char_val.texture = load("res://Character/PlayerCharacter/" + char_id + "/" + "I_" + char_id + ".png")
		char_val.visible = true
	elif not charm_id.is_empty():
		charm_val.texture = load("res://Assets/charm/" + charm_id + ".png")
		charm_val.visible = true
