@tool
extends HBoxContainer

@onready var atk_value = $Stats/Attack/Value
@onready var def_value = $Stats/Defence/Value
@onready var speed_value = $Stats/Speed/Value
@onready var hp_progress_bar = $Stats/HP/ProgressBarContainer/ProgressBar
@onready var health_label = $Stats/HP/ProgressBarContainer/HealthLabelContainer/HealthLabel
@onready var max_health_label = $Stats/HP/ProgressBarContainer/HealthLabelContainer/MaxHealthLabel
@onready var icon = $CharacterIcon/Icon

@export var progress_color: Color:
	set(value):
		progress_color = value
		if hp_progress_bar:
			hp_progress_bar.material.set_shader_parameter(
				"PROGRESS_COLOR",
				value,
			)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func connect_character(_character):
	# signal connection
	_character.stat.atk_updated.connect(_on_atk_updated)
	_character.stat.def_updated.connect(_on_def_updated)
	_character.stat.speed_updated.connect(_on_speed_updated)
	_character.stat.health_updated.connect(_on_health_updated)
	_character.stat.max_health_updated.connect(_on_max_health_updated)
	
	# on-ready value set
	atk_value.text = str(_character.stat.atk)
	def_value.text = str(_character.stat.def)
	speed_value.text = str(_character.stat.speed)
	hp_progress_bar.value = _character.stat.max_health
	hp_progress_bar.max_value = _character.stat.max_health
	health_label.text = str(_character.stat.max_health)
	max_health_label.text = str(_character.stat.max_health)
	icon.texture = _character.icon_texture

func _on_atk_updated(new_value:int) -> void:
	atk_value.text = str(new_value)
func _on_def_updated(new_value:int) -> void:
	def_value.text = str(new_value)
func _on_speed_updated(new_value:int) -> void:
	speed_value.text = str(new_value)
func _on_health_updated(new_value:int) -> void:
	hp_progress_bar.value = new_value 
	health_label.text = str(new_value)
func _on_max_health_updated(new_value:int) -> void:
	hp_progress_bar.max_value = new_value
	max_health_label.text = str(new_value)
