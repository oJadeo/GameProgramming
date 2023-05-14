extends Node

var save:SaveGame

signal character_level_up(char_id,level)
signal charm_unlocked(charm_id)
signal character_unlocked(char_id)

# Called when the node enters the scene tree for the first time.
func _ready():
	create_or_load_save()

func create_or_load_save():
	if SaveGame.save_exists():
		save = SaveGame.load_savegame() as SaveGame
	else:
		save = SaveGame.new()
		
		save.unlockedLevels = [] 
		save.character_level = {"PC1":1,"PC2":1,"PC3":1,"PC4":0,"PC5":0,"PC6":0}
		save.character_exp = {"PC1":0,"PC2":0,"PC3":0,"PC4":0,"PC5":0,"PC6":0}
		save.unlockedCharms= {"C1":false,"C2":false,"C3":false,"C4":false,"C5":false}
		save.unlockedFormations= {"F1":false,"F2":false,"F3":false,"F4":false,"F5":false}
		save.write_savegame()

func print_data():
	print("LV:",save.unlockedLevels)
	print("PC:",save.character_level)
	print("Charm:",save.unlockedCharms)


func get_unlock_level():
	return save.unlockedLevels 

func unlock_level(level:String) -> void:
	if level in save.unlockedLevels:
		return
		
	save.unlockedLevels.append(level)
	save.write_savegame()

func get_unlock_charm():
	return save.charm 
	
	
func unlock_charm(charm:String) -> void:
	if save.charm[charm]:
		return
		
	emit_signal("charm_unlocked",charm)
	save.charm[charm] = true
	save.write_savegame()
	

func unlock_character(char:String) -> void:
	save.character_level[char] = 1
	emit_signal("character_unlocked",char)
	save.write_savegame()

func get_character_level(char:String) -> int:
	if char in save.character_level:
		return save.character_level[char]
	return 0

func get_charm(charm_id:String) -> bool:
	return save.unlockedCharms[charm_id]

func add_exp(exp:int) -> void:
	for char_data in PlayerVar.charDataList:
		save.character_exp[char_data["char_id"]] += exp
		var level = check_level_up(save.character_exp[char_data["char_id"]],save.character_level[char_data["char_id"]],char_data["char_id"])
		if level > save.character_level[char_data["char_id"]]:
			save.character_level[char_data["char_id"]] = level
			emit_signal("character_level_up",char_data["char_id"],level)

func check_level_up(exp:int,lv:int,char_id:String) -> int:
	match lv:
		1:
			if exp > 10:
				var level = check_level_up(exp-10,lv+1,char_id)
				if level > 2:
					return level
				return 2
		2:
			if exp > 30:
				var level = check_level_up(exp-30,lv+1,char_id)
				if level > 3:
					return level
				return 3
		3:
			if exp > 75:
				var level = check_level_up(exp-75,lv+1,char_id)
				if level > 4:
					return level
				return 4
		4:
			if exp > 200:
				return 5
	return lv
				
	
