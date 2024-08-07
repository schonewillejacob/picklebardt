extends Node
class_name PickleballPlayer

@export var playerName : String



# Virtuals ####################################################
func _init(player_name : String = "player") -> void:
	playerName = player_name

func _to_string() -> String:
	return playerName

# Signals #####################################################
# Helpers #####################################################
