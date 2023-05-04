extends Node2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_direction(dir:Vector2):
	sprite.flip_h = dir != Vector2(1,0)

func play_bomb():
	animation.play("Bomb")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
