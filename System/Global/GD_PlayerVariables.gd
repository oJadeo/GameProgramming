extends Node


var allLevelOrder = [1,2,3,4,5,6]
#var unlockedLevels = ["11"] #add more every prevent stage clears
var charDataList = [null,null,null]
var selectedLevel = null
#var charLevel = {"PC1":1,"PC2":1,"PC3":1,"PC4":1,"PC5":1,"PC6":1}
var id2name = {"PC1":"Naruto","PC2":"Sakura","PC3":"Sasuke","PC4":"Itachi","PC5":"Deidara","PC6":"Kisame"}
var skill_data = load("res://System/Global/skill_list.json").get_data()
var charm_data = load("res://System/Global/charm_list.json").get_data()

#var selected_level:int

func get_skill_unlocked_level(char_id,skill_id):
	return skill_data[char_id][skill_id].unlock_level

func get_charm_info(charm_id):
	if charm_id in charm_data:
		return charm_data[charm_id]
	return null
