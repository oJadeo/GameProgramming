extends TextureRect

@onready var zero_icon = load("res://Assets/character select/stay.png")
@onready var plus_icon = load("res://Assets/character select/increase.png")
@onready var minus_icon = load("res://Assets/character select/decrease.png")
@export var attribute: String

func _ready():
	set_texture(zero_icon)

func set_sign(mod:int,show_zero:bool):
	visible = true
	if mod == 0:
		if show_zero:
			set_texture(zero_icon)
		else:
			visible = false
	elif mod > 0:
		set_texture(plus_icon)
	else:
		set_texture(minus_icon)
		

