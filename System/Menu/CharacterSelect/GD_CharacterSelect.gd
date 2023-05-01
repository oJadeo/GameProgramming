extends Control

signal setChar()

var cur_slot

func _ready():
	setChar.connect(get_parent().set_char_done.bind(cur_slot))
	pass
	
func set_char_slot(slot_id):
	cur_slot = slot_id

func _on_back_pressed():
	setChar.emit()
	queue_free()
