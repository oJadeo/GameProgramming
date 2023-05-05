extends Control

signal setChar()

var cur_slot
var selected_char = null
var selected_skills = []
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

func init_scene(slot_id,char_id):
	cur_slot = slot_id
	selected_char = char_id
	
	set_character(selected_char)
	$SkillWindow/SkillButtons.visible = false
	$SkillBar/EquipSkill.visible = false
	$SkillWindow/SkillDesc.visible = false
	if char_id == null:
		$ConfirmSelection.disabled = true
	selected_skills = []
	
	if PlayerVar.charDataList[slot_id]:
		set_stat(PlayerVar.charDataList[cur_slot].char_id)
		selected_skills = PlayerVar.charDataList[cur_slot].skills
		$SkillBar/EquipSkill.visible = true
		
	set_skill_bar()

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
	
func set_stat(char_id):
	if char_id == null:
		return
		
	var char_path = "res://Character/PlayerCharacter/" + char_id + "/S_" + char_id +".tscn"
	var chr = load(char_path).instantiate()
	var chr_level = GlobalSave.get_character_level(char_id)

	chr.get_stat(chr_level)
	
	$Label2.text = PlayerVar.id2name[char_id]
	$Label3.text = "Level " + str(chr_level)
	$StatDetails/Label.text =  "HP:       " + str(chr.stat.health)
	$StatDetails/Label2.text = "ATK:     " + str(chr.stat.atk)
	$StatDetails/Label3.text = "DEF:     " + str(chr.stat.def)
	$StatDetails/Label4.text = "SPD:     " + str(chr.stat.speed)
	
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
	
func set_character(char_id):
	$ConfirmSelection.disabled = false
	if selected_char and char_id and selected_char != char_id:
		selected_skills = []
	selected_char = char_id
	set_stat(char_id)
	$SkillBar/EquipSkill.visible = true
	$SkillWindow/SkillButtons.visible = false
	for button in $CharButtons.get_children():
		button.reset()
		if button.char_id != char_id:
			#button.reset()
			for i in range(3):
				if i != cur_slot and PlayerVar.charDataList[i] and PlayerVar.charDataList[i].char_id == button.char_id:
					button.used(i+1)
		else:
			button.select()
	button_skill_locked = []
	if char_id:
		for button in $SkillWindow/SkillButtons.get_children():
			print(PlayerVar.get_skill_unlocked_level(char_id,button.skill_id))
			if GlobalSave.get_character_level(char_id) >= PlayerVar.get_skill_unlocked_level(char_id,button.skill_id):
				button.default_icon = load("res://Assets/" + char_id + "/grey/" + char_id + "_" + button.skill_id + ".png")
				button.selected_icon = load("res://Assets/" + char_id + "/selected/" + char_id + "_" + button.skill_id + ".png")
				button.hover_icon = load("res://Assets/" + char_id + "/" + char_id + "_" + button.skill_id + ".png")
				button.reset()
			else:
				button_skill_locked.append(button.skill_id)
				button.lock()
	print(button_skill_locked)
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
	
func _on_back_pressed():
	queue_free()

func _on_confirm_selection_pressed():
	if selected_char:
		var char_data = {"char_id":selected_char,"skills":selected_skills,"charm":"1"}
		get_parent().set_char_done(cur_slot,char_data)
	queue_free()


func _on_equip_skill_pressed():
	$SkillWindow/SkillButtons.visible = true
	for button in $SkillWindow/SkillButtons.get_children():
		if button.skill_id in selected_skills:
			button.select()

func _process(delta):
	pass
