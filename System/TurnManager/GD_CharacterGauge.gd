extends Panel

signal on_gauge_new_value

@onready var icon = $Icon
var character: Character
var gauge_value: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_character(new_character: Character):
	character = new_character
	icon.set_texture(character.icon_texture)
	character.stat.gauge_updated.connect(_on_guage_updated)
	character.stat.health_updated.connect(_on_health_updated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_guage_updated(new_value: float) -> void:
	gauge_value = new_value
	var width: float = get_size().x
	icon.set_position(Vector2((100-new_value)*width/100, 0))
	emit_signal("on_gauge_new_value")

func _on_health_updated(new_value:float) -> void:
	if new_value <= 0:
		queue_free()
	
