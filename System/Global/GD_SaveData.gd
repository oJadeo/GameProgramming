class_name SaveGame
extends Resource

const SAVE_GAME_PATH = "user://savegame.tres"

var allLevelOrder = ["11","12","21","22","23","24"]
var unlockedLevels = ["11","12","21","22"]
var character_level = {"PC1":3,"PC2":1,"PC3":1,"PC4":0,"PC5":0,"PC6":0}
var unlockedCharms = {"C1":true,"C2":true,"C3":false,"C4":false,"C5":false}


func write_savegame() -> void:
	ResourceSaver.save(self,SAVE_GAME_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"")
	
