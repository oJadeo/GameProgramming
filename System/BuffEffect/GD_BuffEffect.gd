extends Node2D

@onready var label:Label = $LabelContainer/DamageLabel
@onready var pic = $LabelContainer/TextureRect
@onready var timer = $Timer
@export var height:int =1
var buff_pic = {}
var debuff_pic ={}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_position(Vector2(0,- 40))
	timer.start()
	buff_pic = {
		"atk":"res://Assets/Skills/typeOfAbility/attackBuff.png",
		"def":"res://Assets/Skills/typeOfAbility/defenseBuff.png",
		"spd":"res://Assets/Skills/typeOfAbility/speedBuff.png"
	}
	debuff_pic = {
		"atk":"res://Assets/Skills/typeOfAbility/attackDebuff.png",
		"def":"res://Assets/Skills/typeOfAbility/defenseDebuff.png",
		"spd":"res://Assets/Skills/typeOfAbility/speedDebuff.png"
	}

func set_effect(is_buff:bool,type:String,value:int)->void:
	pic.texture = load(buff_pic[type]) if is_buff else load(debuff_pic[type])
	label.text = str(value)
	var buff_color = Color8(0,155,255,255) if is_buff else Color8(255,0,0,255)
	label.add_theme_color_override("font_color", buff_color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	queue_free()
