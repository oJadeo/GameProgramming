extends Control

func _ready():
	checkStartCondition()
	
func checkStartCondition():
	var startButton = $VBoxContainer/Start
	if PlayerVar.charDataList[0] and PlayerVar.charDataList[1] and PlayerVar.charDataList[2]:
		startButton.disabled = false
	else:
		startButton.disabled = true

func set_stage(level_name:String):
	#Load stage information (map/enemy/reward)
	print(level_name) 

func set_char_done(slot_id,char_data):
	var prv_slot_id = -1
	for i in range(3):
		if PlayerVar.charDataList[i] and PlayerVar.charDataList[i].char_id == char_data.char_id:
			prv_slot_id = i
			break
	if prv_slot_id == -1:
		PlayerVar.charDataList[slot_id] = char_data
	else:
		PlayerVar.charDataList[prv_slot_id] = null
		PlayerVar.charDataList[slot_id] = char_data
		
	$VBoxContainer/HBoxContainer/Char1.text = PlayerVar.charDataList[0].char_id if PlayerVar.charDataList[0] else "Null 1"
	$VBoxContainer/HBoxContainer/Char2.text = PlayerVar.charDataList[1].char_id if PlayerVar.charDataList[1] else "Null 2"
	$VBoxContainer/HBoxContainer/Char3.text = PlayerVar.charDataList[2].char_id if PlayerVar.charDataList[2] else "Null 3"
		
	checkStartCondition()		
	
func _on_start_pressed():
	var next_scene = load("res://Level/S_TestLevel.tscn").instantiate()
	#next_scene.set_stage(level_name)
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
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

func _on_back_pressed():
	get_tree().change_scene_to_file("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")
	queue_free()
