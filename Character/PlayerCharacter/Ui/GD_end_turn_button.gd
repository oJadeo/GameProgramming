extends VBoxContainer

@onready var player = $"../.."
@onready var move_btn = $MoveButton
@onready var end_btn =$EndTurnButton
# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_end_turn.connect(change)

func change(can_player_end_turn:bool):
	end_btn.visible = can_player_end_turn
	move_btn.visible = !can_player_end_turn
		

func _on_move_pressed():
	player.select_move()

func _on_end_turn_pressed():
	player.end_turn()

func _on_move_button_pressed():
	player.select_move()

func _on_end_turn_button_pressed():
	player.end_turn()
