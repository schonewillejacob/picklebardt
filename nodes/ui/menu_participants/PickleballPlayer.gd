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
func add_to_playerBinaryLedger(inserted_player_playerBinaryID : int) -> bool:
	if !exists_in_playerBinaryLedger(inserted_player_playerBinaryID):
		playerBinaryLedger += inserted_player_playerBinaryID
		return true
	
	push_error(str(inserted_player_playerBinaryID) + " is already in ledger")
	return false

func exists_in_playerBinaryLedger(requesting_player_id : int) -> bool:
	if playerBinaryLedger & requesting_player_id != 0:
		return true
	
	return false
