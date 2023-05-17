extends CharacterManager

func _ready() -> void:
	super()
	Board.enemy_list = all_character

func update_list() -> void:
	Board.enemy_list = all_character

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_finish_level():
	if len(Board.enemy_list) == 0:
		print("HERE")
		var current_scene = get_tree().get_current_scene()
		if current_scene is LEVEL:
			print("HERE2")
			current_scene.win_level()
