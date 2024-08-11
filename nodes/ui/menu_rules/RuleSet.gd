extends Node
class_name RuleSet

@export_group("Rules")
@export var courtSize : int
@export var courtsAvailable : int
@export var shuffleSeed : int = 0
var playerSlots : int = 0



# Virtuals ####################################################
func _init(courts_available : int = 1, court_size : int = 4, shuffle_seed : int = 0):
	courtsAvailable = courts_available
	playerSlots = courts_available * court_size
	shuffleSeed = shuffle_seed
