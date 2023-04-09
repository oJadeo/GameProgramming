extends Node
class_name CharacterManager

var rng = RandomNumberGenerator.new()
@onready var character_node = $Characters
signal change_character_turn(character)
var all_character = []

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	update_all_character()
	random_start_guage()
	
func update_all_character()->void:
	all_character = character_node.get_children()
	
func random_start_guage()->void:
	for character in all_character:
		character.set_gauge(rng.randf_range(-5.0,5.0))
		
func update_tick(delta:float)->bool:
	var is_next_turn = false 
	for character in all_character: 
		if character.update_tick(delta):
			is_next_turn = true
			emit_signal('change_character_turn',character)
	return is_next_turn

func end_turn():
	get_parent().end_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	pass
