extends Node
class_name RuleSet

@export_group("Rules")
@export var courtSize : int
@export var courtsAvailable : int
@export var shuffleSeed : int
var playerSlots : int = 0



# Virtuals ####################################################
func _init(courts_available : int, court_size : int, shuffle_seed = null):
	courtsAvailable = courts_available
	playerSlots = courts_available * court_size
	if shuffleSeed != null: shuffleSeed = shuffle_seed
