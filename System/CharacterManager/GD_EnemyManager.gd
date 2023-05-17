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
	print("check!")
	if len(Board.enemy_list) == 0:
		print("enter!")
		var current_scene = get_parent().get_parent()
		if current_scene is LEVEL:
			current_scene.win_level()
