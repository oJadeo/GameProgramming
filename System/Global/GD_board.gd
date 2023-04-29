extends Node

var board_size: Vector2 = Vector2(9,5)
var board_global_position: Vector2 = Vector2.ZERO
var board_tile
var board
var tile_size:Vector2
var x_offset:int
var player_list:Array
var enemy_list:Array
var select_tile =[]

enum GET_TILE{
	empty,
	unit,
	all
}
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	board = []
	for i in range(board_size.y):
		var row = []
		for j in range(board_size.x):
			row.append(null)
		board.append(row)
	pass # Replace with function body.
func is_cood_in_board(cood:Vector2) -> bool:
	if cood.x < 0 or cood.x >= board_size.x:
		return false
	if cood.y < 0 or cood.y >= board_size.y:
		return false
	return true
func get_tile_pos(cood:Vector2)->Vector2:
	return board_global_position+Vector2(tile_size.x*cood.x+((board_size.y-cood.y)*x_offset),tile_size.y*cood.y)
func get_cood(object:Character):
	for i in range(board_size.y):
		for j in range(board_size.x):
			if board[i][j] == object:
				return Vector2(j,i)
	print("Can't find Character")
func change_cood(object:Character,new_cood:Vector2)->void:
	var old_cood = object.board_cood
	if old_cood == new_cood:
		print("Can't change cood(same cood)")
		return
	if 0 > new_cood.y and new_cood.y >= board_size.y and 0 > new_cood.x and new_cood.x >= board_size.x:
		print("Can't change cood outside board:",new_cood)
		return
	if board[new_cood.y][new_cood.x] != null:
		print("Can't change cood already has:",board[new_cood.y][new_cood.x])
		return
	board[old_cood.y][old_cood.x] = null
	board[new_cood.y][new_cood.x] = object
func get_character(cood:Vector2):
	if 0 <= cood.y and cood.y  < board_size.y and 0 <= cood.x and cood.x < board_size.x:
		return board[cood.y][cood.x]
	return null
func get_highlight()-> Array:
	var result = []
	for i in range(board_size.y):
		for j in range(board_size.x):
			if board_tile[i][j].hoverable:
				result.append(Vector2(j,i))
	return result
func reset_all_tile() -> void:
	for row in board_tile:
		for tile in row:
			tile.reset()
	select_tile.clear()
func add_select_tile(tiles):
	select_tile.append_array(tiles)
func highlight_tiles(tiles_cood:Array,get_tile:int) -> void:
	for cood in tiles_cood:
		if 0 <= cood.y and cood.y  < board_size.y and 0 <= cood.x and cood.x < board_size.x:
			board_tile[cood.y][cood.x].highlight()
			match get_tile:
				GET_TILE.empty:
					if not board[cood.y][cood.x]:
						board_tile[cood.y][cood.x].hoverable = true
				GET_TILE.unit:
					if board[cood.y][cood.x]:
						board_tile[cood.y][cood.x].hoverable = true
				GET_TILE.all:
					board_tile[cood.y][cood.x].hoverable = true
func delete_character(cood:Vector2) ->void:
	board[cood.y][cood.x] = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	pass
