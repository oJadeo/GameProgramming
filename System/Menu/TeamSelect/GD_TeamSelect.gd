extends Control

var draw_data = []
var enemy_cood = load("res://Level/Data/emeny_cood.json").get_data()
var player_cood = load("res://Level/Data/player_start_cood.json").get_data()
var swapping = []

func _ready():
	var top_l = $ReferenceTopGrid.position + Vector2(0,$ReferenceTopGrid.size.y)
	var top_r = $ReferenceTopGrid.position + $ReferenceTopGrid.size
	var btm_l = $ReferenceBtmGrid.position
	var btm_r = $ReferenceBtmGrid.position + Vector2($ReferenceBtmGrid.size.x,0)
	var v_grid = 5
	var h_grid = 9
	draw_data = $Util.calculateGrid(top_l,top_r,btm_l,btm_r,h_grid,v_grid)
	set_text()
	checkStartCondition()
	draw_enemy()
	draw_player()
	$Label3.text = "Level " + str(PlayerVar.selectedLevel)
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	
func draw_enemy():
	var offset = Vector2(15,25)
	var scale
	for enemy in enemy_cood[PlayerVar.selectedLevel]:
		var enemy_name = enemy[0]
		var enemy_cood = enemy[1]
		var enemyPic = TextureRect.new()
		if enemy_name in ["BOSS1","BOSS2"]:
			enemyPic.set_texture( load("res://System/Menu/TeamSelect/boss.png"))
			scale = 2.5
		else:
			enemyPic.set_texture( load("res://System/Menu/TeamSelect/enemy.png"))
			scale = 2
		enemyPic.set_position(draw_data[1][4-enemy_cood.y][enemy_cood.x]-offset*scale)
		enemyPic.scale = Vector2(scale,scale)
		add_child(enemyPic)
		
func draw_player():
	for prv_pos in $PlayerPos.get_children():
		prv_pos.queue_free()
		
	for i in range(3):
		var p_cood = player_cood[PlayerVar.selectedLevel][i]
		var char_pos = load("res://System/Menu/TeamSelect/GD_CharacterPos.tscn").instantiate()
		if PlayerVar.charDataList[i]:
			char_pos.set_character(PlayerVar.charDataList[i].char_id)
		else:
			char_pos.set_text(i)
		print(p_cood)
		print(len(draw_data))
		char_pos.set_position(draw_data[1][4-p_cood.y][p_cood.x])
		$PlayerPos.add_child(char_pos)
	
func checkStartCondition():
	var startButton = $ConfirmSelection
	if PlayerVar.charDataList[0] and PlayerVar.charDataList[1] and PlayerVar.charDataList[2]:
		startButton.disabled = false
	else:
		startButton.disabled = true
		
func set_text():
	$Slot1.update_button()
	$Slot2.update_button()
	$Slot3.update_button()
	
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
	#draw_player()
	checkStartCondition()

func init_character_select(slot_id):
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	var char_select_scene = load("res://System/Menu/CharacterSelect/GD_CharacterSelect.tscn").instantiate()

	if PlayerVar.charDataList[slot_id]:
		char_select_scene.init_scene(slot_id,PlayerVar.charDataList[slot_id].char_id)
	else:
		char_select_scene.init_scene(slot_id,null)
	get_tree().get_root().add_child(char_select_scene)
	queue_free()
	
func add_swap(slot_id):
	swapping.append(slot_id)
	if len(swapping) == 2:
		var temp = PlayerVar.charDataList[swapping[0]]
		PlayerVar.charDataList[swapping[0]] = PlayerVar.charDataList[swapping[1]]
		PlayerVar.charDataList[swapping[1]] = temp
		swapping = []
		set_text()
		draw_player()
		$Slot1.set_swap(false)
		$Slot2.set_swap(false)
		$Slot3.set_swap(false)
		$Swap.set_pressed(false)

func _on_back_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")
	queue_free()

func _on_node_2d_draw():
	for i in draw_data[0]:
		$Node2D.draw_line(i[0],i[1],Color(0, 0, 0),3)

func _on_confirm_selection_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Util.change_scene("res://Level/S_TestLevel.tscn")
	queue_free()
	
func _on_swap_toggled(button_pressed):
	if button_pressed:
		$Slot1.set_swap(true)
		$Slot2.set_swap(true)
		$Slot3.set_swap(true)
