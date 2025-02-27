extends Node
class_name RuleSet



var courtSize : int
var courtsAvailable : int
var shuffleSeed : int
var playerSlots : int = 0



# Virtuals ####################################################
func _init(courts_available : int, court_size : int, shuffle_seed : int):
	courtsAvailable = courts_available
	courtSize = court_size
	set_playerSlots()
	shuffleSeed = shuffle_seed

func _to_string() -> String:
	return "courtSize: "+str(courtSize)+", courtsAvailable: "+str(courtsAvailable)+", playerSlots: "+str(playerSlots)+", shuffleSeed: "+str(shuffleSeed)

func set_playerSlots():
	if courtSize>0 and courtsAvailable>0:
		playerSlots = courtsAvailable * courtSize
	else:
		push_error("playerSlots == 0")
