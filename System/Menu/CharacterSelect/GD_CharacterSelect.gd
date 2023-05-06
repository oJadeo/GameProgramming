extends Control

var cur_slot
var selected_char = null
var selected_skills = []
var selected_charm = null
var button_skill_locked = []

func _ready():
	for button in $CharButtons.get_children():
		button.get_node("TextureButton").connect('pressed',set_character.bind(button.char_id))
		if GlobalSave.get_character_level(button.char_id) == 0:
			button.visible = false
			
	for button in $SkillWindow/SkillButtons.get_children():
		button.get_node("TextureButton").connect('pressed',set_skill.bind(button.skill_id))
		button.get_node("TextureButton").connect('mouse_entered',show_skill_desc.bind(button.skill_id))
		button.get_node("TextureButton").connect('mouse_exited',hide_skill_desc)
		
	for button in $CharmWindow/CharmButtons.get_children():
		button.get_node("TextureButton").connect('pressed',set_charm.bind(button.charm_id))
		button.get_node("TextureButton").connect('mouse_entered',show_charm_desc.bind(button.charm_id))
		button.get_node("TextureButton").connect('mouse_exited',hide_charm_desc)

func init_scene(slot_id,char_id):
	cur_slot = slot_id
	selected_char = char_id
	set_character(selected_char)
	
	$SkillWindow.visible = false
	$SkillBar/EquipSkill.visible = false
	$SkillWindow/SkillDesc.visible = false
	
	$CharmWindow.visible = false
	$CharmBar/EquipCharm.visible = false
	$CharmWindow/CharmDesc.visible = false
	
	$StatDetails/Label2.visible = false
	$StatDetails/Label3.visible = false
	$StatDetails/ModifySigns2.visible = false
	
	if char_id == null:
		$ConfirmSelection.disabled = true
		
	selected_skills = []
	selected_charm = null
	
	if PlayerVar.charDataList[slot_id]:
		set_stat(PlayerVar.charDataList[cur_slot].char_id)
		selected_skills = PlayerVar.charDataList[cur_slot].skills
		selected_charm = PlayerVar.charDataList[cur_slot].charm
		$SkillBar/EquipSkill.visible = true
		$CharmBar/EquipCharm.visible = true
		
	set_skill_bar()
	set_charm_bar()

func get_formatted_string(stat):
	var s = ""
	for i in ["health","atk","def","speed"]:
		s += str(stat[i])
		if i!="speed":
			s += "\n"
	return s
	
func set_stat(char_id):
	if char_id == null:
		return
		
	var char_path = "res://Character/PlayerCharacter/" + char_id + "/S_" + char_id +".tscn"
	var chr = load(char_path).instantiate()
	var chr_level = GlobalSave.get_character_level(char_id)

	chr.get_stat(chr_level)
	$StatDetails/Label2.visible = true
	$Label2.text = PlayerVar.id2name[char_id]
	$Label3.text = "Level " + str(chr_level)
	$StatDetails/Label.text =  "HP:\nATK:\nDEF\nSPD:"
	$StatDetails/Label2.text = get_formatted_string(chr.stat)
	
	match char_id:
		"PC1","PC2":
			chr.apply_scale(Vector2(1.5,1.5))
			chr.set_position(Vector2(800,400))
		"PC3":
			chr.apply_scale(Vector2(1.4,1.4))
			chr.set_position(Vector2(800,400))
		"PC4","PC5":
			chr.apply_scale(Vector2(1.2,1.2))
			chr.set_position(Vector2(800,420))
		"PC6" :
			chr.apply_scale(Vector2(1.1,1.1))
			chr.set_position(Vector2(800,430))
			
	for prv_chr in $CharSprite.get_children():
		prv_chr.queue_free()
		
	$CharSprite.add_child(chr)
	
func update_charm_stat():
	if selected_charm:
		$StatDetails/Label3.visible = true
		$StatDetails/ModifySigns2.visible = true
		var chr = $CharSprite.get_child(0)
		var chr_level = GlobalSave.get_character_level(selected_char)
		chr.get_stat(chr_level)
		var charm_info = PlayerVar.charm_data[selected_charm]
		var mod_stat = {}
		mod_stat.health = chr.stat.health + charm_info.hp
		mod_stat.atk = chr.stat.atk + charm_info.atk
		mod_stat.def = chr.stat.def + charm_info.def
		mod_stat.speed = chr.stat.speed + charm_info.speed
		$StatDetails/Label3.text = get_formatted_string(mod_stat)
		for mod in $StatDetails/ModifySigns2.get_children():
			mod.set_sign(charm_info[mod.attribute],false)
		
func set_character(char_id):
	$ConfirmSelection.disabled = false
	if selected_char and char_id and selected_char != char_id:
		selected_skills = []
		selected_charm = null
		$SkillBar/EquipSkill.set_pressed(false)
		$CharmBar/EquipCharm.set_pressed(false)
		$StatDetails/Label3.visible = false
		$StatDetails/ModifySigns2.visible = false
		
	selected_char = char_id
	set_stat(char_id)
	
	$SkillBar/EquipSkill.visible = true
	$SkillWindow/SkillButtons.visible = false
	$CharmBar/EquipCharm.visible = true
	$CharmWindow/CharmButtons.visible = false
	
	for button in $CharButtons.get_children():
		button.reset()
		if button.char_id != char_id:
			for i in range(3):
				if i != cur_slot and PlayerVar.charDataList[i] and PlayerVar.charDataList[i].char_id == button.char_id:
					button.used(i+1)
		else:
			button.select()
	button_skill_locked = []
	if char_id:
		for button in $SkillWindow/SkillButtons.get_children():
			if GlobalSave.get_character_level(char_id) >= PlayerVar.get_skill_unlocked_level(char_id,button.skill_id):
				button.default_icon = load("res://Assets/" + char_id + "/grey/" + char_id + "_" + button.skill_id + ".png")
				button.selected_icon = load("res://Assets/" + char_id + "/selected/" + char_id + "_" + button.skill_id + ".png")
				button.hover_icon = load("res://Assets/" + char_id + "/" + char_id + "_" + button.skill_id + ".png")
				button.reset()
			else:
				button_skill_locked.append(button.skill_id)
				button.lock()
				
	for button in $CharmWindow/CharmButtons.get_children():
		if GlobalSave.get_charm(button.charm_id):
			button.default_icon = load("res://Assets/charm/grey/" + button.charm_id + ".png")
			button.selected_icon = load("res://Assets/charm/selected/" + button.charm_id + ".png")
			button.hover_icon = load("res://Assets/charm/" + button.charm_id + ".png")
			button.reset()
		else:
			button.visible = false
			
	set_skill_bar()
	set_charm_bar()

#################### SKILL ####################

func _on_equip_skill_toggled(button_pressed):
	if button_pressed:
		$CharmWindow.visible = false
		$CharmBar/EquipCharm.set_pressed(false)
		$SkillBar/EquipSkill.text = "   Equip Skill"
		$SkillBar/EquipSkill/TextureRect.visible = true
		$SkillWindow.visible = true
		$SkillWindow/SkillButtons.visible = true
		for button in $SkillWindow/SkillButtons.get_children():
			if button.skill_id in selected_skills:
				button.select()
	else:
		$SkillWindow.visible = false
		$SkillBar/EquipSkill.text = "Equip Skill"
		$SkillBar/EquipSkill/TextureRect.visible = false
		
func set_skill(skill_id):
	if skill_id in button_skill_locked:
		return
	if skill_id in selected_skills:
		selected_skills.erase(skill_id)
		for button in $SkillWindow/SkillButtons.get_children():
			if button.skill_id == skill_id:
				button.reset()
	elif len(selected_skills) == 2:
		pass
	else:
		selected_skills.append(skill_id)
		for button in $SkillWindow/SkillButtons.get_children():
			if button.skill_id == skill_id:
				button.select()
	selected_skills.sort()
	set_skill_bar()
	
func set_skill_bar():
	if selected_char == null:
		return
	
	if len(selected_skills)>0:
		$SkillBar/SkillIcons/SkillIcon.set_texture( load("res://Assets/" + selected_char + "/" + selected_char + "_" + selected_skills[0] + ".png"))
	else:
		$SkillBar/SkillIcons/SkillIcon.set_texture( load("res://Assets/character select/default_blank.png"))
	if len(selected_skills)>1:
		$SkillBar/SkillIcons/SkillIcon2.set_texture( load("res://Assets/" + selected_char + "/" + selected_char + "_" + selected_skills[1] + ".png"))
	else:
		$SkillBar/SkillIcons/SkillIcon2.set_texture( load("res://Assets/character select/default_blank.png"))
	
	
func show_skill_desc(skill_id):
	$SkillWindow/SkillDesc.visible = true
	if skill_id in button_skill_locked:
		$SkillWindow/SkillDesc/ColorRect.color = Color.html("#fabdaa")
		$SkillWindow/SkillDesc/ColorRect/Label.text = "Locked"
		$SkillWindow/SkillDesc/ColorRect2/Label2.text = "???"
		$SkillWindow/SkillDesc/ColorRect3/Label3.text = "Unlocked at Lv. " + str(PlayerVar.get_skill_unlocked_level(selected_char,skill_id))
	else:
		var skill_info = PlayerVar.skill_data[selected_char][skill_id]
		$SkillWindow/SkillDesc/ColorRect.color = Color.html("#b0faaa")
		$SkillWindow/SkillDesc/ColorRect/Label.text = skill_info.title
		$SkillWindow/SkillDesc/ColorRect2/Label2.text = skill_info.description
		$SkillWindow/SkillDesc/ColorRect3/Label3.text = "Cooldown: " + str(skill_info.cd) + " Turns"
	
func hide_skill_desc():
	$SkillWindow/SkillDesc.visible = false
	
#################### CHARM ####################
func _on_equip_charm_toggled(button_pressed):
	if button_pressed:
		$SkillWindow.visible = false
		$SkillBar/EquipSkill.set_pressed(false)
		$CharmBar/EquipCharm.text = "   Equip Charm"
		$CharmBar/EquipCharm/TextureRect.visible = true
		$CharmWindow.visible = true
		$CharmWindow/CharmButtons.visible = true
		for button in $CharmWindow/CharmButtons.get_children():
			if button.charm_id == selected_charm:
				button.select()
	else:
		$CharmWindow.visible = false
		$CharmBar/EquipCharm.text = "Equip Charm"
		$CharmBar/EquipCharm/TextureRect.visible = false
		
func set_charm(charm_id):
	if charm_id == selected_charm:
		selected_charm = null
		for button in $CharmWindow/CharmButtons.get_children():
			button.reset()
	else:
		selected_charm = charm_id
		for button in $CharmWindow/CharmButtons.get_children():
			if button.charm_id == charm_id:
				button.select()
			else:
				button.reset()
	set_charm_bar()
	update_charm_stat()
	
func set_charm_bar():
	if selected_char == null:
		return
	
	if selected_charm:
		$CharmBar/CharmIcon/CharmIcon.set_texture( load("res://Assets/charm/" + selected_charm + ".png"))
	else:
		$CharmBar/CharmIcon/CharmIcon.set_texture( load("res://Assets/character select/default_blank.png"))
	
func formatted_desc(charm_info):
	var s = ""
	for i in ["hp","atk","def","speed"]:
		if charm_info[i] > 0:
			s += "+" + str(charm_info[i])
		elif charm_info[i] < 0:
			s += str(charm_info[i])
		else:
			s += " 0"
		if i!="speed":
			s += "\n"
	return s
	
func show_charm_desc(charm_id):
	$CharmWindow/CharmDesc.visible = true
	var charm_info = PlayerVar.charm_data[charm_id]
	var charm_desc = formatted_desc(charm_info)
	$CharmWindow/CharmDesc/ColorRect.color = Color.html("#b0faaa")
	$CharmWindow/CharmDesc/ColorRect/Label.text = charm_info.title
	$CharmWindow/CharmDesc/ColorRect2/Labels/Label3.text = charm_desc
	for mod in $CharmWindow/CharmDesc/ColorRect2/ModifySigns.get_children():
		mod.set_sign(charm_info[mod.attribute],true)
		
func hide_charm_desc():
	$CharmWindow/CharmDesc.visible = false

func _on_back_pressed():
	queue_free()
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			queue_free()

func _on_confirm_selection_pressed():
	if selected_char:
		var char_data = {"char_id":selected_char,"skills":selected_skills,"charm":selected_charm}
		get_parent().set_char_done(cur_slot,char_data)
	queue_free()
