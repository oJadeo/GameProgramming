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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_guage_updated(new_value:float) -> void:
	gauge_bar.value = new_value 
	
func _on_health_updated(new_value:int) -> void:
	health_bar.value = new_value 

func _on_max_health_updated(new_value:int) -> void:
	health_bar.max_value = new_value
