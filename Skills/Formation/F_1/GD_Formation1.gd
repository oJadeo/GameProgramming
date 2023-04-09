extends BaseSkills

func _ready() -> void:
	pass # Replace with function body.

func select() -> void:
	pass
	
func select_target(cood:Vector2) -> void:
	super(cood)

func check_target()->bool:
	var can_do = false
	
	return can_do

func finish_skill() -> void:
	super()
	player.end_turn()

func update(delta:float) -> void:
	pass

func deselect() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	pass

