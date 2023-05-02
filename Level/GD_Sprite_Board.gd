extends Node2D

@export var tile:Resource
var board_tile
var board_size:Vector2
@export var tile_size:Vector2
@export var x_offset:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Board.board_global_position = get_position()
	Board.tile_size = tile_size
	Board.x_offset = x_offset
	board_size = Board.board_size
	board_tile = []
	for i in range(board_size.y):
		var board_tile_row = []
		for j in range(board_size.x):
			var new_tile = tile.instantiate()
			add_child(new_tile)
			new_tile.set_position(Vector2(tile_size.x*j+((board_size.y-i)*x_offset),tile_size.y*i))
			new_tile.init(Vector2(j,i))
			board_tile_row.append(new_tile)
		board_tile.append(board_tile_row)
	Board.board_tile = board_tile
	Board.reset_all_tile()
