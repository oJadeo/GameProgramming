extends Node

@export var level:int
@export var enemylist:NodePath
@export var enemy_data_json:JSON
@export var EM1:Resource
@export var EM2:Resource
@export var EM3:Resource
@export var EM4:Resource
@export var BOSS1:Resource
@export var BOSS2:Resource

var enemy_scene:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_scene["EM1"] = EM1
	enemy_scene["EM2"] = EM2
	enemy_scene["EM3"] = EM3
	enemy_scene["EM4"] = EM4
	enemy_scene["BOSS1"] = BOSS1
	enemy_scene["BOSS2"] = BOSS2
	
	select_level(level)

func select_level(lv:int):
	var all_level_data = enemy_data_json.get_data()
	var level_data = all_level_data[lv]
	
	for enemy_data in level_data:
		var enemy = enemy_scene[enemy_data[0]]
		var enemy_cood = Vector2(enemy_data[1].x,enemy_data[1].y)
		
		print(enemy,":",enemy_cood)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

