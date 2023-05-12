extends ColorRect
@export var default_icon:Texture2D
@export var selected_icon:Texture2D
@export var hover_icon:Texture2D
@export var used_icon:Texture2D
@export var char_id:String

func _ready():
	$TextureButton.set_texture_hover(hover_icon)
	
func reset():
	$TextureButton.set_texture_normal(default_icon)
	color = Color.html("#00000000")
	$ColorRect2.visible = false

func select():
	$TextureButton.set_texture_normal(selected_icon)
	color = Color.html("#001aff")
	$ColorRect2.visible = false

func used(pos:int):
	$TextureButton.set_texture_normal(used_icon)
	color = Color.html("#ff0000")
	$ColorRect2.visible = true
	$ColorRect2.color = Color.html("#ff0000")
	$ColorRect2/Label.text = "P"+str(pos)
