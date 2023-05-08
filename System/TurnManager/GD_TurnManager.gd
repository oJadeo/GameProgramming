extends Node2D

var total_turn:int = 0

@export var tick_multiplier:float = 1
@onready var player_manager = $PlayerManager
@onready var enemy_manager = $EnemyManager
@onready var ui = $PlayerManager/CanvasLayer
enum State{
	Character_Turn,
	Waiting_Next_Turn
}

var current_state
var current_turn_unit
var next_unit = []
var playing = false
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	change_state(State.Waiting_Next_Turn)
	player_manager.connect("change_character_turn",change_character_turn)
	enemy_manager.connect("change_character_turn",change_character_turn)
	ui.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	if playing:
		match current_state:
			State.Character_Turn:
				pass
			State.Waiting_Next_Turn:
				_process_waiting_next_turn(delta)
		if not ui.visible:
			ui.visible = true

func start_level():
	playing = true

# Tick according to speed to cal who go next
var tick_end = false
func _process_waiting_next_turn(delta)->void:
	update_tick(delta*tick_multiplier)
func update_tick(delta)->void:
	tick_end = player_manager.update_tick(delta) or tick_end
	tick_end = enemy_manager.update_tick(delta) or tick_end 
	if tick_end:
		change_state(State.Character_Turn)

func _input(event)->void:
	if event.is_action("test_input"):
		match current_state:
			State.Character_Turn:
				change_state(State.Waiting_Next_Turn)
			State.Waiting_Next_Turn:
				pass
func change_state(new_state)->void:
	#End current State
	match current_state:
		State.Character_Turn:	
			current_turn_unit = null
		State.Waiting_Next_Turn:
			pass
	
	current_state = new_state
	#Setting Start new state
	match new_state:
		State.Character_Turn:
			pass
		State.Waiting_Next_Turn:
			tick_end = false
func change_character_turn(character)->void:
	if not current_turn_unit:
		character.start_turn()
		current_turn_unit = character
	else:
		next_unit.append(character)

func end_turn()->void:
	if len(next_unit) == 0:
		change_state(State.Waiting_Next_Turn)
	else:
		if next_unit[0].stat.gauge > 100:
			next_unit[0].start_turn()
			current_turn_unit = next_unit[0]
			next_unit.remove_at(0)
		else:
			next_unit.remove_at(0)
			end_turn()
		
func start_player_move():
	$PlayerSpawner.start_player_move()
	
func start_enemy_move():
	$EnemySpawner.start_enemy_move()
