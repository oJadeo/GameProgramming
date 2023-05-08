extends Node

@export var level:int
@onready var player_list_node = $"../PlayerManager/Characters"
@export var player_data_json:JSON
@export var PC1:Resource
@export var PC2:Resource
@export var PC3:Resource
@export var PC4:Resource
@export var PC5:Resource
@export var PC6:Resource
var pc_dict
var selected_PC
@onready var turnline = $"../PlayerManager/CanvasLayer/TurnLineManager"

var start_velocity = []

var player_scene:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	pc_dict = {
		"PC1":PC1,
		"PC2":PC2,
		"PC3":PC3,
		"PC4":PC4,
		"PC5":PC5,
		"PC6":PC6
	}
	select_level(level)

func select_level(lv:int):
	var all_level_data = player_data_json.get_data()
	var level_data = all_level_data[lv]
	
	for i in range(len(PlayerVar.charDataList)):
		var char_data = PlayerVar.charDataList[i]
		var player_cood = Vector2(level_data[i].x,level_data[i].y)

		var player_instance = pc_dict[char_data["char_id"]].instantiate()
		player_instance.start_cood = player_cood
		player_instance.start_direction = Vector2(1,0)
		player_instance.charm = char_data["charm"]
		player_instance.level = GlobalSave.get_character_level(char_data["char_id"])
		player_instance.equip_skill_list = char_data["skills"]
		player_list_node.add_child(player_instance)
		
		start_velocity.append(player_instance.global_position.x + 100)
		
		player_instance.global_position.x = - 100
		
	player_list_node.get_parent().update_all_character()
	player_list_node.get_parent().random_start_guage()
	
	Board.player_list = player_list_node.get_children()
	
	turnline.update_player_list()
	
	
func start_player_move():
	$MoveTimer.start()
	for player in Board.player_list:
		player.play_animaiton("Walk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $MoveTimer.is_stopped():
		for i in len(Board.player_list):
			var player =  Board.player_list[i]
			player.global_position.x += start_velocity[i]*delta

func _on_move_timer_timeout():
	for player in Board.player_list:
		player.return_to_idle()
		player.global_position = Board.get_tile_pos(player.board_cood)
