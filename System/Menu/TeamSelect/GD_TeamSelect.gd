extends Control

func _ready():
	set_text()
	checkStartCondition()
	
func checkStartCondition():
	var startButton = $VBoxContainer/Start
	if PlayerVar.charDataList[0] and PlayerVar.charDataList[1] and PlayerVar.charDataList[2]:
		startButton.disabled = false
	else:
		startButton.disabled = true
		
func set_text():
	$VBoxContainer/HBoxContainer/Char1.text = PlayerVar.charDataList[0].char_id if PlayerVar.charDataList[0] else "Null 1"
	$VBoxContainer/HBoxContainer/Char2.text = PlayerVar.charDataList[1].char_id if PlayerVar.charDataList[1] else "Null 2"
	$VBoxContainer/HBoxContainer/Char3.text = PlayerVar.charDataList[2].char_id if PlayerVar.charDataList[2] else "Null 3"

func set_stage(level_name:String):
	#Load stage information (map/enemy/reward)
	#print(level_name) 
	pass

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
		
	set_text()
	checkStartCondition()		
	
func _on_start_pressed():
	var next_scene = load("res://Level/S_TestLevel.tscn").instantiate()
	print(PlayerVar.charDataList)
	#next_scene.set_stage(level_name)
	get_tree().get_root().add_child(next_scene)
	get_tree().set_current_scene(next_scene)
	queue_free()

func init_character_select(slot_id):
	var char_select_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()

	if PlayerVar.charDataList[slot_id]:
		char_select_scene.init_scene(slot_id,PlayerVar.charDataList[slot_id].char_id)
	else:
		char_select_scene.init_scene(slot_id,null)
	add_child(char_select_scene)
	
func _on_char_1_pressed():
	init_character_select(0)

func _on_char_2_pressed():
	init_character_select(1)

func _on_char_3_pressed():
	init_character_select(2)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")
	queue_free()

func _on_node_2d_draw():
	var top_l = $ReferenceTopGrid.position + Vector2(0,$ReferenceTopGrid.size.y)
	var top_r = $ReferenceTopGrid.position + $ReferenceTopGrid.size
	var btm_l = $ReferenceBtmGrid.position
	var btm_r = $ReferenceBtmGrid.position + Vector2($ReferenceBtmGrid.size.x,0)
	var v_grid = 5
	var h_grid = 10
	var draw_data = $Util.calculateGrid(top_l,top_r,btm_l,btm_r,h_grid,v_grid)
	for i in draw_data[0]:
		$Node2D.draw_line(i[0],i[1],Color(255, 0, 0),5)
