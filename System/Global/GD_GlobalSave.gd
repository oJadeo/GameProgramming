extends Node

var save:SaveGame

# Called when the node enters the scene tree for the first time.
func _ready():
	create_or_load_save()

func create_or_load_save():
	if SaveGame.save_exists():
		save = SaveGame.load_savegame() as SaveGame
		print_data()
	else:
		save = SaveGame.new()
		
		save.unlockedLevels = ["11"] 
		save.character_level = {"PC1":1,"PC2":1,"PC3":1,"PC4":0,"PC5":0,"PC6":0}
		save.unlockedCharms= {"C1":false,"C2":false,"C3":false,"C4":false,"C5":false}
		
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
		
	save.charm[charm] = true
	save.write_savegame()
	

func change_character_level(char:String,level:int) -> void:
	save.character_level[char] = level
	save.write_savegame()

func get_character_level(char:String) -> int:
	if char in save.character_level:
		return save.character_level[char]
	return 0

func get_charm(charm_id:String) -> bool:
	return save.unlockedCharms[charm_id]
