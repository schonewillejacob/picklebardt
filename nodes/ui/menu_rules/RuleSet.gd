extends Node
class_name RuleSet



var courtSize : int
var courtsAvailable : int
var shuffleSeed : int
var playerSlots : int = 0



# Virtuals ####################################################
func _init(courts_available : int, court_size : int, shuffle_seed : int):
	courtsAvailable = courts_available
	playerSlots = courts_available * court_size
	shuffleSeed = shuffle_seed

func _to_string() -> String:
	return "courtSize: "+str(courtSize)+", courtsAvailable: "+str(courtsAvailable)+", playerSlots: "+str(playerSlots)+", hash(shuffleSeed): "+str(hash(shuffleSeed))
