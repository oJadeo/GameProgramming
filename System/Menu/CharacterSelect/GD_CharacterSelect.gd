extends Control

signal setChar()

var cur_slot
@onready var selected_char = null

func _ready():
	for button in $HBoxContainer/VBoxContainer/GridContainer.get_children():
		button.connect('pressed',reset_except.bind(button.char_id))
	
func set_char_slot(slot_id):
	cur_slot = slot_id
	for button in $HBoxContainer/VBoxContainer/GridContainer.get_children():
		button.reset()
		for i in range(3):
			if PlayerVar.charDataList[i] and button.char_id == PlayerVar.charDataList[i].char_id:
				if i == cur_slot:
					button.select()
				else:
					button.used()
	
func _on_back_pressed():
	if selected_char:
		var char_data = {"char_id":selected_char,"skill":["skill1","skill2"],"charm":"1"}
		get_parent().set_char_done(cur_slot,char_data)
	queue_free()

func reset_except(char_id):
	selected_char = char_id
	for button in $HBoxContainer/VBoxContainer/GridContainer.get_children():
		if button.char_id != char_id:
			button.reset()
			for i in range(3):
				if i != cur_slot and PlayerVar.charDataList[i] and PlayerVar.charDataList[i].char_id == button.char_id:
					button.used()
		else:
			button.select()
