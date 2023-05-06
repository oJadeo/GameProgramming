extends Node

@export var level:int
@onready var enemy_list_node = $"../EnemyManager/Characters"
@export var enemy_data_json:JSON
@export var EM1:Resource
@export var EM2:Resource
@export var EM3:Resource
@export var EM4:Resource
@export var BOSS1:Resource
@export var BOSS2:Resource

@onready var turnline = $"../PlayerManager/CanvasLayer/TurnLineManager"

var start_velocity = []

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
		
		var enemy_instance = enemy.instantiate()
		enemy_instance.start_cood = enemy_cood
		enemy_instance.start_direction = Vector2(-1,0)
		enemy_list_node.add_child(enemy_instance)
		
		start_velocity.append(enemy_instance.global_position.x - 2020)
		
		enemy_instance.global_position.x = 2020

	enemy_list_node.get_parent().update_all_character()
	enemy_list_node.get_parent().random_start_guage()
	
	Board.enemy_list = enemy_list_node.get_children()
	
	turnline.update_enemy_list()
	
func start_enemy_move():
	$MoveTimer.start()
	for enemy in Board.enemy_list:
		enemy.play_animaiton("Walk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $MoveTimer.is_stopped():
		for i in len(Board.enemy_list):
			var enemy =  Board.enemy_list[i]
			enemy.global_position.x += start_velocity[i]*delta


func _on_move_timer_timeout():
	for enemy in Board.enemy_list:
		enemy.return_to_idle()
		enemy.global_position = Board.get_tile_pos(enemy.board_cood)
