extends Node
class_name PickleballPlayer

@export var playerName : String
@export var playerBinaryID : int
var playerBinaryLedger : int = 0 # players start with an empty ledger.


# Virtuals ####################################################
func _init(player_name : String = "player", player_binary_id : int = 0) -> void:
	playerName = player_name
	playerBinaryID = player_binary_id

func _to_string() -> String:
	return playerName

# Signals #####################################################
# Helpers #####################################################
func clear_ledger():
	playerBinaryLedger = 0

func push_to_playerBinaryLedger(inserted_player_playerBinaryID : int):
	playerBinaryLedger = playerBinaryLedger | inserted_player_playerBinaryID # binary OR

func exists_in_playerBinaryLedger(requesting_player_id : int) -> bool:
	if not playerBinaryLedger & requesting_player_id == 0:
		return true
	
	return false
