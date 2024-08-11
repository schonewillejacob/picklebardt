extends Node
class_name PickleballPlayer

@export var playerName : String
@export var playerBinaryID : int



# Virtuals ####################################################
func _init(player_name : String = "player", player_binary_id : int = 0) -> void:
	playerName = player_name
	playerBinaryID = playerBinaryID

func _to_string() -> String:
	return playerName

# Signals #####################################################
# Helpers #####################################################
