class_name SaveGame
extends Resource

const SAVE_GAME_PATH = "user://savegame.tres"


var allLevelOrder = [1,2,3,4,5,6]
var unlockedLevels = [1,2,3,4,5,6]
var character_level = {"PC1":5,"PC2":5,"PC3":5,"PC4":5,"PC5":5,"PC6":5}
var character_exp = {"PC1":0,"PC2":0,"PC3":0,"PC4":0,"PC5":0,"PC6":0}
var unlockedCharms = {"C1":true,"C2":true,"C3":false,"C4":false,"C5":false}
var unlockedFormations= {"F1":true,"F2":true,"F3":true,"F4":true}

func write_savegame() -> void:
	ResourceSaver.save(self,SAVE_GAME_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"")
	
