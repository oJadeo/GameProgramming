extends TextureButton
@export var default_icon:Texture2D
@export var selected_icon:Texture2D
@export var used_icon:Texture2D
@export var char_id:String
var state = 0

func reset():
	set_texture_normal(default_icon)
	state = 0

func select():
	set_texture_normal(selected_icon)
	state = 1

func used():
	set_texture_normal(used_icon)
	state = 2
