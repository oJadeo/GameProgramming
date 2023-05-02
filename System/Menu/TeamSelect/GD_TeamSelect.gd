extends Control

var charDataList = [null,null,null]
func _ready():
	checkStartCondition()
	
func checkStartCondition():
	var startButton = $VBoxContainer/Start
	if charDataList[0] and charDataList[1] and charDataList[2]:
		startButton.disabled = false
	else:
		startButton.disabled = true

func set_stage(level_name:String):
	#Load stage information (map/enemy/reward)
	print(level_name) 

func set_char_done(slot_id,char_data):
	var prv_slot_id = -1
	for i in range(len(charDataList)):
		if charDataList[i] and charDataList[i].char_id == char_data.char_id:
			prv_slot_id = i
			break
	if prv_slot_id == -1:
		charDataList[slot_id] = char_data
	else:
		charDataList[prv_slot_id] = null
		charDataList[slot_id] = char_data
		
	$VBoxContainer/HBoxContainer/Char1.text = charDataList[0].char_id if charDataList[0] else "Null 1"
	$VBoxContainer/HBoxContainer/Char2.text = charDataList[1].char_id if charDataList[1] else "Null 2"
	$VBoxContainer/HBoxContainer/Char3.text = charDataList[2].char_id if charDataList[2] else "Null 3"
		
	#print(charDone)
	checkStartCondition()		
	
func _on_start_pressed():
	var next_scene = load("res://Level/S_TestLevel.tscn").instantiate()
	#next_scene.set_stage(level_name)
	add_child(next_scene)


func _on_char_1_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(0,charDataList)
	add_child(next_scene)


func _on_char_2_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(1,charDataList)
	add_child(next_scene)


func _on_char_3_pressed():
	var next_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()
	next_scene.set_char_slot(2,charDataList)
	add_child(next_scene)


func _on_back_pressed():
	queue_free()
