extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSave.change_character_level("PC3",3)
	GlobalSave.print_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win_level()-> void:
	match PlayerVar.selectedLevel:
		1:
			GlobalSave.add_exp(12)
		2:
			GlobalSave.add_exp(27)
		3:
			GlobalSave.add_exp(35)
			GlobalSave.unlock_charm("C1")
			GlobalSave.unlock_charm("C4")
			GlobalSave.unlock_character("PC4")
		4:
			GlobalSave.add_exp(35)
			GlobalSave.unlock_charm("C2")
			GlobalSave.unlock_charm("C5")
			GlobalSave.unlock_character("PC5")
			GlobalSave.unlock_character("PC6")
		5:
			GlobalSave.add_exp(50)
			GlobalSave.unlock_charm("C3")
		6:
			GlobalSave.add_exp(100)

func lose_level() -> void:
	pass

