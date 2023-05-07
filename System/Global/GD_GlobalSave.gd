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
		
		save.unlockedLevels = [true,false,false,false,false,false] 
		save.character_level = [1,1,1,0,0,0]
		save.charm = [false,false,false,false,false]
		
		save.write_savegame()

func print_data():
	print("LV:",save.unlockedLevels)
	print("PC:",save.character_level)
	print("Charm:",save.charm)


func get_unlock_level() -> void:
	save.unlockedLevels 

func unlock_level(level:int) -> void:
	if save.unlockedLevels[level]:
		return
		
	save.unlockedLevels[level] = true
	save.write_savegame()

func get_unlock_charm() -> void:
	save.charm 
	
	
func unlock_charm(charm:int) -> void:
	if save.charm[charm]:
		return
		
	save.charm[charm] = true
	save.write_savegame()
	

func change_character_level(char:int,level:int) -> void:
	save.character_level[char-1] = level
	save.write_savegame()
