class_name SaveGame
extends Resource

const SAVE_GAME_PATH = "user://savegame.tres"

var allLevelOrder = ["11","12","21","22","23","24"]
var unlockedLevels = [true,false,false,false,false,false] 
var character_level = [1,1,1,0,0,0]
var charm = [false,false,false,false,false]


func write_savegame() -> void:
	ResourceSaver.save(self,SAVE_GAME_PATH)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH,"")
	
