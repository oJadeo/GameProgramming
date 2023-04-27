extends Control

@onready var gauge_bar = $GaugeBar
@onready var health_bar = $HealthBar
@onready var character = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character.stat.gauge_updated.connect(_on_guage_updated)
	character.stat.health_updated.connect(_on_health_updated)
	character.stat.max_health_updated.connect(_on_max_health_updated)
	health_bar.max_value = character.stat.max_health
	health_bar.value = character.stat.max_health
	gauge_bar.visible = false
	health_bar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func show_bar() -> void:
	gauge_bar.visible = true
	health_bar.visible = true

func hide_bar() -> void:
	gauge_bar.visible = false
	health_bar.visible = false

func _on_guage_updated(new_value:float) -> void:
	gauge_bar.value = new_value 
	
func _on_health_updated(new_value:int) -> void:
	health_bar.value = new_value 

func _on_max_health_updated(new_value:int) -> void:
	health_bar.max_value = new_value

func _on_area_2d_mouse_entered():
	show_bar()

func _on_area_2d_mouse_exited():
	hide_bar()
