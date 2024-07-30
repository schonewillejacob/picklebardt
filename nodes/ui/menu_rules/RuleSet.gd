extends Node
class_name RuleSet

@export_group("Rules")
@export var CourtSize : int = 4
@export var courtsAvailable : int = 1
var playerSlots : int = 0



func _init(_courtsAvailable : int):
	courtsAvailable = _courtsAvailable
	playerSlots = _courtsAvailable * CourtSize
