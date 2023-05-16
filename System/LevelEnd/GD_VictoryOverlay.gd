extends Control

var exp_lists = [0,12,27,35,35,50,100]
var max_exp = [0,10,30,75,200,0]

var char_id_list = []
var old_character_lv = {}
var new_character_lv = {}

@onready var reward_lists = $ColorRect/ColorRect/VBox_rewards
@onready var exp_guage_container_lists = $ColorRect/ColorRect/VBox_characters
@onready var character_upgrade_lists = $ColorRect/ColorRect/VBox_charUp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update():
	old_character_lv = get_character_lv()
	set_reward()
	new_character_lv = get_character_lv()
	update_exp()
	update_character()
	
func get_character_lv():
	var character_lv = {}
	for i in range(len(PlayerVar.charDataList)):
		var char_data = PlayerVar.charDataList[i]
		character_lv[char_data["char_id"]] = GlobalSave.get_character_level(char_data["char_id"])
		char_id_list.append(char_data["char_id"])
	return character_lv
		
func set_reward():
	GlobalSave.add_exp(exp_lists[PlayerVar.selectedLevel])
	var exp_reward_container = $ColorRect/ColorRect/VBox_rewards/RewardContainer
	exp_reward_container.reward_name = "Exp"
	exp_reward_container.reward_exp = exp_lists[PlayerVar.selectedLevel]
	exp_reward_container.update_display()
	
	match PlayerVar.selectedLevel:
		3:
			GlobalSave.unlock_charm("C1")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.reward_name = "new charm"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.charm_id = "C1"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.visible = true
			GlobalSave.unlock_charm("C4")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.reward_name = "new charm"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.charm_id = "C4"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.visible = true
			GlobalSave.unlock_character("PC4")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.reward_name = "new character"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.char_id = "PC4"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.visible = true
		4:
			GlobalSave.unlock_charm("C2")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.reward_name = "new charm"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.charm_id = "C2"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.visible = true
			GlobalSave.unlock_charm("C5")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.reward_name = "new charm"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.charm_id = "C5"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer3.visible = true
			GlobalSave.unlock_character("PC5")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.reward_name = "new character"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.char_id = "PC5"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer4.visible = true
			GlobalSave.unlock_character("PC6")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer5.reward_name = "new character"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer5.char_id = "PC6"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer5.visible = true
		5:
			GlobalSave.unlock_charm("C3")
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.reward_name = "new charm"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.charm_id = "C3"
			$ColorRect/ColorRect/VBox_rewards/RewardContainer2.visible = true

func update_exp():
	for i in range(3):
		var container = exp_guage_container_lists.get_child(i)
		var char_id = char_id_list[i]
		container.char_name = char_id
		container.lvl = new_character_lv[char_id]
		container.c_exp = GlobalSave.get_character_exp(char_id)
		container.g_exp = max_exp[container.lvl]
		container.lvl_up = new_character_lv[char_id] > old_character_lv[char_id]
		
		container.update_display()

func update_character():
	for i in range(3):
		var container = character_upgrade_lists.get_child(i)
		var char_id = char_id_list[i]
		var lvl_up = new_character_lv[char_id] > old_character_lv[char_id]
		container.char_name = char_id
		container.char_id = char_id
		container.visible = lvl_up
		if lvl_up:
			set_up_character_level_up(container,char_id)
			container.update_display()
				
func set_up_character_level_up(container:Node,char_id:String):
	var stat_json = load("res://Character/PlayerCharacter/"+char_id+"/"+char_id.to_lower() +"_stat.json")
	var stat_data = stat_json.get_data()
	var old_lv = old_character_lv[char_id]
	var new_lv = new_character_lv[char_id]
	container.char_id = char_id
	container.atk =  stat_data[new_lv]['atk']
	container.atk_up =  stat_data[new_lv]['atk'] > stat_data[old_lv]['atk']
	container.def =  stat_data[new_lv]['def']
	container.def_up =  stat_data[new_lv]['def'] > stat_data[old_lv]['def']
	container.spd =  stat_data[new_lv]['speed']
	container.spd_up =  stat_data[new_lv]['speed'] > stat_data[old_lv]['speed']
	container.hp =  stat_data[new_lv]['hp']
	container.hp_up =  stat_data[new_lv]['hp'] > stat_data[old_lv]['hp']
	
	var skill_up = []
	match char_id:
		"PC1":
			if old_character_lv[char_id] < 2 and new_character_lv[char_id] >= 2:
				skill_up.append("S2")
			if old_character_lv[char_id] < 4 and new_character_lv[char_id] >= 4:
				skill_up.append("S3")
		"PC2":
			if old_character_lv[char_id] < 2 and new_character_lv[char_id] >= 2:
				skill_up.append("S2")
			if old_character_lv[char_id] < 3 and new_character_lv[char_id] >= 3:
				skill_up.append("S3")
		"PC3":
			if old_character_lv[char_id] < 3 and new_character_lv[char_id] >= 3:
				skill_up.append("S2")
			if old_character_lv[char_id] < 4 and new_character_lv[char_id] >= 4:
				skill_up.append("S3")
		"PC4":
			if old_character_lv[char_id] < 4 and new_character_lv[char_id] >= 4:
				skill_up.append("S3")
		"PC5":
			if old_character_lv[char_id] < 3 and new_character_lv[char_id] >= 3:
				skill_up.append("S2")
				skill_up.append("S3")
		"PC6":
			if old_character_lv[char_id] < 3 and new_character_lv[char_id] >= 3:
				skill_up.append("S2")
				skill_up.append("S3")
	
	for i in range(len(skill_up)):
		match i:
			0:
				container.skill_id_1 = skill_up[i]
			1:
				container.skill_id_2 = skill_up[i]

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://System/Menu/MainMenu/GD_MainMenu.tscn")

func _on_next_level_pressed():
	var cur_level = PlayerVar.selectedLevel
	if cur_level < PlayerVar.allLevelOrder[-1]:
		var next_level = cur_level + 1
		PlayerVar.selectedLevel = next_level
		GlobalSave.unlock_level(next_level)
		get_tree().change_scene_to_file("res://System/Menu/TeamSelect/GD_TeamSelect.tscn")
	else:
		get_tree().change_scene_to_file("res://System/Menu/LevelSelect/GD_LevelSelect.tscn")


