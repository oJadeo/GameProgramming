extends Node2D

var total_turn:int = 0

@onready var player_manager = $PlayerManager
@onready var enemy_manager = $EnemyManager
@onready var tick_timer = $TickTimer

enum State{
	Character_Turn,
	Waiting_Next_Turn
}

var current_state
var current_turn_unit
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	change_state(State.Waiting_Next_Turn)
	player_manager.connect("change_character_turn",change_character_turn)
	enemy_manager.connect("change_character_turn",change_character_turn)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	match current_state:
		State.Character_Turn:
			pass
		State.Waiting_Next_Turn:
			_process_waiting_next_turn(delta)


# Tick according to speed to cal who go next
var tick_end = false
func _process_waiting_next_turn(delta)->void:
	if not tick_timer.is_stopped():
		update_tick(delta)
func update_tick(delta)->void:
	tick_end = player_manager.update_tick(delta) or tick_end
	tick_end = enemy_manager.update_tick(delta) or tick_end 
	if tick_end:
		change_state(State.Character_Turn)
func _on_tick_timer_timeout()->void:
	if current_state == State.Waiting_Next_Turn:
		tick_timer.start()

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
			tick_timer.stop()
	
	current_state = new_state
	#Setting Start new state
	match new_state:
		State.Character_Turn:
			pass
		State.Waiting_Next_Turn:
			tick_end = false
			tick_timer.start()
func change_character_turn(character)->void:
	character.start_turn()
	current_turn_unit = character

func end_turn()->void:
	change_state(State.Waiting_Next_Turn)
