extends VBoxContainer

@onready var player = $"../.."
@onready var move_btn = $Move
@onready var end_btn = $EndTurn
# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_end_turn.connect(change)

func change(can_player_end_turn:bool):
	end_btn.visible = can_player_end_turn
	move_btn.visible = !can_player_end_turn
		
