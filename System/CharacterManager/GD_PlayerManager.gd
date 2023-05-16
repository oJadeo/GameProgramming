extends CharacterManager

var formation_btn_list:Array
var _formation_tooltip = load("res://System/TurnManager/S_FormationTooltip.tscn")

func _ready() -> void:
	super()
	Board.player_list = all_character
	formation_btn_list = $CanvasLayer/FormationButtons.get_children()
	$CanvasLayer.visible = true
	for i in len(formation_btn_list):
		var _skill = formation_btn_list[i].get_child(0)

		formation_btn_list[i].visible = false
		formation_btn_list[i].pressed.connect(select_formation.bind(i))

		var _tooltip = _formation_tooltip.instantiate()
		_tooltip.name = "tooltip_formation_" + str(i + 1)
		$CanvasLayer/Tooltips.add_child(_tooltip)

		var _tooltip_num: int = $CanvasLayer/Tooltips.get_child_count() - 1

		_tooltip.set_tooltip_desc(_skill.skill_name, _skill.skill_description)
		formation_btn_list[i].mouse_entered.connect(tooltip_show.bind(_tooltip_num))
		formation_btn_list[i].mouse_exited.connect(tooltip_hide)
		_tooltip.visible = false
		
func check_formation(character: Character) -> bool:
	var can_formation:bool = false
	for i in len(formation_btn_list):
		var skill = formation_btn_list[i].get_child(0)
		skill.init(character)
		var can = skill.check_target()
		formation_btn_list[i].visible = can
		can_formation = can or can_formation
	return can_formation
	
func update_list() -> void:
	Board.player_list = all_character
	
func select_formation(num: int) -> void:
	for btn in formation_btn_list:
		btn.get_child(0).deselect()
	
	var skill = formation_btn_list[num].get_child(0)
	get_parent().current_turn_unit.select_formation(skill)
	skill.select()

func tooltip_show(_num: int) -> void:
	tooltip_hide()
	var _tooltips = $CanvasLayer/Tooltips.get_children()
	_tooltips[_num].set_showing(true)
	pass

func tooltip_hide() -> void:
	var _tooltips = $CanvasLayer/Tooltips.get_children()
	for i in _tooltips:
		i.set_showing(false)

func check_finish_level():
	if len(Board.player_list) == 0:
		get_tree().get_current_scene().lose_level()

func end_turn():
	super()
	for i in len(formation_btn_list):
		formation_btn_list[i].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
