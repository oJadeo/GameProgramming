extends Sprite2D

var is_hover:bool = false
var hoverable:bool = false
var is_highlight:bool = false
var cood:Vector2 = Vector2(-1,-1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init(_cood:Vector2)->void:
	cood = _cood

func hover()->void:
	set_frame(2)
	set_z_index(2)

func highlight()->void:
	is_highlight = true
	set_frame(1)
	set_z_index(1)
func reset() -> void:
	is_highlight = false
	is_hover = false
	hoverable = false
	set_frame(0)
	set_z_index(0)
	
func _on_area_2d_mouse_entered() -> void:
	if is_highlight and hoverable:
		is_hover = true
		hover()
		for select_cood in Board.select_tile:
			Board.board_tile[cood.y+select_cood.y][select_cood.x+select_cood.x].hover()

func _on_area_2d_mouse_exited() -> void:
	if is_hover:
		is_hover = false
		highlight()
		for select_cood in Board.select_tile:
			var tile = Board.board_tile[cood.y+select_cood.y][select_cood.x+select_cood.x]
			if tile.is_highlight:
				tile.highlight()
			else:
				tile.reset()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_hover and event.is_action_pressed("select"):
		get_tree().call_group("character","select_target",cood)
