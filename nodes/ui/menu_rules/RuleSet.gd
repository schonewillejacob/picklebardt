extends Node
class_name RuleSet

const COURT_SIZE : int = 4

@export var courtsAvailable = 0
var playerSlots = 0



func _init(_courtsAvailable : int):
	courtsAvailable = _courtsAvailable
	playerSlots = _courtsAvailable * COURT_SIZE
