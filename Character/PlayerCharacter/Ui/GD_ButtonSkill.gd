extends TextureButton

@onready var character = $"../../.."
@onready var sprite:Sprite2D = $Sprite
@onready var cooldown_label:Label = $Sprite/Label
var cooldown:int = 0
var focus:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.mouse_entered.connect(on_mouse_entered)
	self.mouse_exited.connect(on_mouse_exited)
	self.focus_entered.connect(on_focus_entered)
	self.focus_exited.connect(on_focus_exited)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_cooldown(turn: int):
	cooldown = turn
	if turn <= 0:
		disabled = false
		sprite.set_frame_coords(Vector2i(0, 0))
		cooldown_label.visible = false
		pass
	else:
		disabled = true
		sprite.set_frame_coords(Vector2i(3, 0))
		cooldown_label.text = str(turn)
		cooldown_label.visible = true
		pass
	pass

func set_spritesheet(_sprite: Texture):
	sprite.set_texture(_sprite)

func on_mouse_entered():
	if cooldown <= 0 and not focus:
		sprite.set_frame_coords(Vector2i(1, 0))
	pass # Replace with function body.

func on_mouse_exited():
	if cooldown <= 0 and not focus:
		sprite.set_frame_coords(Vector2i(0, 0))
	pass # Replace with function body.

func on_focus_entered():
	if cooldown <= 0:
		sprite.set_frame_coords(Vector2i(2, 0))
		focus = true
	pass # Replace with function body.

func on_focus_exited():
	if cooldown <= 0:
		sprite.set_frame_coords(Vector2i(0, 0))
		focus = false
	pass # Replace with function body.
