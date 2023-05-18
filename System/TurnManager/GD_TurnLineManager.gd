extends Panel

@onready var player_characters = $"../../Characters"
@onready var enemy_characters = $"../../../EnemyManager/Characters"
@export var gauge: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_player_list():
	var player_character_list = player_characters.get_children()
	for c in player_character_list:
		var g = gauge.instantiate()
		g.name = c.name + " gauge"
		add_child(g)
		g.set_character(c)
		g.on_gauge_new_value.connect(update_children_sort)

func update_enemy_list():
	var enemy_character_list = enemy_characters.get_children()
	for c in enemy_character_list:
		var g = gauge.instantiate()
		g.name = c.name + " gauge"
		add_child(g)
		g.set_character(c)
		g.on_gauge_new_value.connect(update_children_sort)

func update_children_sort():
	var _sorted_nodes := get_children()

	_sorted_nodes.sort_custom(
		func(a, b): return a.gauge_value < b.gauge_value
	)

	for node in get_children():
		remove_child(node)

	for node in _sorted_nodes:
		add_child(node)
