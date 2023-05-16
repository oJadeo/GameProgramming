extends Control

@export var slot_id:int
@onready var swapped_mode = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if is_hovered():
	#	$Unselected/Label5.add_theme_color_override("font_color", Color("001aff"))
	#else:
	#	$Unselected/Label5.add_theme_color_override("font_color", Color("000000"))
	pass

func set_swap(swap_mode):
	if swap_mode:
		swapped_mode = true
		var new_stylebox_hover = get_theme_stylebox("hover").duplicate()
		new_stylebox_hover.border_color = Color("ffe600")
		$Button.add_theme_stylebox_override("hover", new_stylebox_hover)
		$Button.add_theme_stylebox_override("pressed", new_stylebox_hover)
	else:
		swapped_mode = false
		var new_stylebox_normal = get_theme_stylebox("normal").duplicate()
		var new_stylebox_hover = get_theme_stylebox("hover").duplicate()
		new_stylebox_hover.border_color = Color("001aff")
		$Button.add_theme_stylebox_override("hover", new_stylebox_hover)
		$Button.add_theme_stylebox_override("pressed", new_stylebox_hover)
func ch2n(char_id):
	match char_id:
		"PC1":
			return "Naruto"
		"PC2":
			return "Sakura"
		"PC3":
			return "Sasuke"
		"PC4":
			return "Itachi"
		"PC5":
			return "Deidara"
		"PC6":
			return "Kisame"	
		
func update_button():
	if slot_id == null or slot_id == -1:
		return
	if PlayerVar.charDataList[slot_id]:
		print(PlayerVar.charDataList[slot_id])
		$Unselected.visible = false
		$Selected.visible = true
		#{"char_id":selected_char,"skills":selected_skills,"charm":selected_charm}
		var char_id = PlayerVar.charDataList[slot_id].char_id
		var skills = PlayerVar.charDataList[slot_id].skills
		var charm = PlayerVar.charDataList[slot_id].charm
		
		$Selected/TextureRect.set_texture(load("res://Assets/character icon/combat&selected/"+char_id+"_"+ch2n(char_id)+".png"))
		$Selected/Label.text = ch2n(char_id)
		var char_path = "res://Character/PlayerCharacter/" + char_id + "/S_" + char_id +".tscn"
		var chr = load(char_path).instantiate()
		var chr_level = GlobalSave.get_character_level(char_id)
		chr.get_stat(chr_level)
		
		var charm_info
		if charm == null:
			charm_info = {"hp":0,"atk":0,"def":0,"speed":0}
		else:
			charm_info = PlayerVar.charm_data[charm]
		var mod_stat = {}
		mod_stat.hp = chr.stat.health + charm_info.hp
		mod_stat.atk = chr.stat.atk + charm_info.atk
		mod_stat.def = chr.stat.def + charm_info.def
		mod_stat.spd = chr.stat.speed + charm_info.speed
		
		$Selected/Label3.text = str(mod_stat.hp)+"\n"+str(mod_stat.atk)+"\n"+str(mod_stat.def)+"\n"+str(mod_stat.spd)+"\n"
		
		match len(skills):
			0:
				$Selected/TextureRect2.visible = false
				$Selected/TextureRect3.visible = false
			1:
				$Selected/TextureRect2.visible = false
				$Selected/TextureRect3.visible = true
				$Selected/TextureRect3.set_texture( load("res://Assets/" + char_id + "/" + char_id + "_" + skills[0] + ".png"))
			2:
				$Selected/TextureRect2.visible = true
				$Selected/TextureRect2.set_texture( load("res://Assets/" + char_id + "/" + char_id + "_" + skills[0] + ".png"))
				$Selected/TextureRect3.visible = true
				$Selected/TextureRect3.set_texture( load("res://Assets/" + char_id + "/" + char_id + "_" + skills[1] + ".png"))
			
	else:
		$Selected.visible = false
		$Unselected.visible = true
		$Unselected/Label4.text = "P"+str(slot_id+1)


func _on_mouse_entered():
	$Unselected/Label5.add_theme_color_override("font_color", Color("001aff"))


func _on_mouse_exited():
	$Unselected/Label5.add_theme_color_override("font_color", Color("000000"))


func _on_pressed():
	get_parent().init_character_select(slot_id)
