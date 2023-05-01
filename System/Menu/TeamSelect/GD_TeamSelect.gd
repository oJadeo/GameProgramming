extends Control

var charDone = [false,false,false]
func _ready():
	checkStartCondition()
	
func checkStartCondition():
	var startButton = $VBoxContainer/Start
	if charDone[0] and charDone[1] and charDone[2]:
		startButton.disabled = false
	else:
		startButton.disabled = true

func set_stage(level_name:String):
	#Load stage information (map/enemy/reward)
	print(level_name) 

func set_char_done(slot_id):
	charDone[slot_id] = true
	match slot_id:
		0:
			$VBoxContainer/HBoxContainer/Char1.text = "Done"
		1:
			$VBoxContainer/HBoxContainer/Char2.text = "Done"
		2:
			$VBoxContainer/HBoxContainer/Char3.text = "Done"
	print(charDone)
	checkStartCondition()		
	
func _on_start_pressed():
	var next_scene = load("res://Level/S_TestLevel.tscn").instantiate()
	#next_scene.set_stage(level_name)
	add_sibling(next_scene)
	queue_free()


func _on_char_1_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(0)
	add_child(next_scene)


func _on_char_2_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(1)
	add_child(next_scene)


func _on_char_3_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(2)
	add_child(next_scene)
