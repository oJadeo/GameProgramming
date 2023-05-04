extends Panel

@onready var player_characters = $"../../Characters"
@onready var enemy_characters = $"../../../EnemyManager/Characters"
@export var gauge:Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_player_list():
	var player_character_list = player_characters.get_children()
	for c in player_character_list:
		var g = gauge.instantiate()
		g.name = c.name + " gauge"
		add_child(g)
		g.set_character(c)


func update_enemy_list():
	var enemy_character_list = enemy_characters.get_children()
	for c in enemy_character_list:
		var g = gauge.instantiate()
		g.name = c.name + " gauge"
		add_child(g)
		g.set_character(c)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
