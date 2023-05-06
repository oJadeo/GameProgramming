extends ColorRect

@export var default_icon:Texture2D
@export var selected_icon:Texture2D
@export var hover_icon:Texture2D
@export var skill_id:String

func _ready():
	$TextureButton.set_texture_hover(hover_icon)

func reset():
	$TextureButton.set_texture_hover(hover_icon)
	$TextureButton.set_texture_normal(default_icon)
	color = Color.html("#00000000")
	$ColorRect2.visible = false

func select():
	$TextureButton.disabled = false
	$TextureButton.set_texture_hover(hover_icon)
	$TextureButton.set_texture_normal(selected_icon)
	color = Color.html("#ff0000")
	$ColorRect2.visible = true
	$ColorRect2.color = Color.html("#ff0000")

func lock():
	$TextureButton.set_texture_normal(load("res://Assets/character select/skilllockedgrey.png"))
	$TextureButton.set_texture_hover(load("res://Assets/character select/skilllocked.png"))
	color = Color.html("#00000000")
	$ColorRect2.visible = false

