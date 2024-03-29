class_name SaveGame
extends Resource

const SAVE_GAME_PATH = "user://savegame.tres"


var allLevelOrder = [1,2,3,4,5,6]
var unlockedLevels = [1]
var character_level = {"PC1":1,"PC2":1,"PC3":1,"PC4":0,"PC5":0,"PC6":0}
var character_exp = {"PC1":0,"PC2":0,"PC3":0,"PC4":0,"PC5":0,"PC6":0}
var unlockedCharms = {"C1":false,"C2":false,"C3":false,"C4":false,"C5":false}
var unlockedFormations= {"F1":false,"F2":false,"F3":false,"F4":false}
var already_played_tutorial = false

func write_savegame() -> void:
	ResourceSaver.save(self,SAVE_GAME_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"")
	
