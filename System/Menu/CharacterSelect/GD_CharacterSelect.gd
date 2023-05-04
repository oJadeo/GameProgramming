extends Control

signal setChar()

var cur_slot
@onready var selected_char = null

func _ready():
	for button in $CharButtons.get_children():
		button.get_node("TextureButton").connect('pressed',reset_except.bind(button.char_id))
	
func set_char_slot(slot_id):
	cur_slot = slot_id
	for button in $CharButtons.get_children():
		button.reset()
		for i in range(3):
			if PlayerVar.charDataList[i] and button.char_id == PlayerVar.charDataList[i].char_id:
				if i == cur_slot:
					button.select()
				else:
					button.used(i+1)
	if PlayerVar.charDataList[cur_slot]:
		get_stat(PlayerVar.charDataList[cur_slot].char_id)
	
func _on_back_pressed():
	queue_free()

func get_stat(char_id):
	print(char_id)
	var char_path = "res://Character/PlayerCharacter/" + char_id + "/S_" + char_id +".tscn"
	#var json_path = "res://Character/PlayerCharacter/" + char_id + "/" + char_id.to_lower() + "_stat.json"
	#var json_file = load(json_path).get_data()
	#print(json_file)
	var chr = load(char_path).instantiate()
	var chr_level = PlayerVar.charLevel[char_id]
	
	$Label2.text = PlayerVar.id2name[char_id]
	$Label3.text = "Level " + str(chr_level)
	
	chr.get_stat(chr_level)
	#print(chr.stat.atk,chr.stat.def,chr.stat.speed,chr.stat.health)
	
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
	
func reset_except(char_id):
	selected_char = char_id
	get_stat(selected_char)
	for button in $CharButtons.get_children():
		if button.char_id != char_id:
			button.reset()
			for i in range(3):
				if i != cur_slot and PlayerVar.charDataList[i] and PlayerVar.charDataList[i].char_id == button.char_id:
					button.used(i+1)
		else:
			button.select()


func _on_confirm_selection_pressed():
	if selected_char:
		var char_data = {"char_id":selected_char,"skill":["skill1","skill2"],"charm":"1"}
		get_parent().set_char_done(cur_slot,char_data)
	queue_free()
