extends Control

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
			
func set_character(char_id):
	$TextureRect2.visible = true
	$Label.visible = false
	$TextureRect2.set_texture(load("res://Assets/character icon/unselected/"+char_id+"_"+ch2n(char_id)+".png"))
	
func set_text(slot_id):
	$TextureRect2.visible = false
	$Label.visible = true
	$Label.text = "P" + str(slot_id+1)
	
