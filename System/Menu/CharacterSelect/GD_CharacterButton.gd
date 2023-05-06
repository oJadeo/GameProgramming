extends TextureButton
@export var default_icon:Texture2D
@export var selected_icon:Texture2D
@export var used_icon:Texture2D
@export var char_id:String

func reset():
	set_texture_normal(default_icon)

func select():
	set_texture_normal(selected_icon)

func used():
	set_texture_normal(used_icon)
	
