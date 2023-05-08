extends CharacterManager

var formation_btn_list:Array
func _ready() -> void:
	super()
	Board.player_list = all_character
	formation_btn_list = $CanvasLayer/FormationButtons.get_children()
	$CanvasLayer.visible = true
	for i in len(formation_btn_list):
		formation_btn_list[i].visible = false
		formation_btn_list[i].pressed.connect(select_formation.bind(i))
		
func check_formation(character:Character) -> bool:
	var can_formation:bool = false
	for i in len(formation_btn_list):
		var skill = formation_btn_list[i].get_child(0)
		skill.init(character)
		var can = skill.check_target()
		formation_btn_list[i].visible = can
		can_formation = can or can_formation
	return can_formation

func select_formation(num:int)->void:
	var skill = formation_btn_list[num].get_child(0)
	get_parent().current_turn_unit.select_formation(skill)
	skill.select()

func check_finish_level():
	if len(Board.player_list) == 0:
		print("Lose")

func end_turn():
	super()
	for i in len(formation_btn_list):
		formation_btn_list[i].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
