extends VBoxContainer

@onready var player = $"../.."
@onready var move_btn = $Move
@onready var end_btn =$EndTurn
# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_end_turn.connect(change)

func change(can_player_end_turn:bool):
	end_btn.visible = can_player_end_turn
	
	if can_player_end_turn:
		move_btn.text = "Cancle move"
	else:
		move_btn.text = "Move"
		

func _on_move_pressed():
	player.select_move()

func _on_end_turn_pressed():
	player.end_turn()
