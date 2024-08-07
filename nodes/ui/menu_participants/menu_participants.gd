extends LerpContainer

## This script/node is here for future use, implementing a dynamic list of member names

# served list of Players.
var participantList : Array = []

func _ready() -> void:
	# This should be empty, we simply use a dummy list for the teams at the moment
	var dummyList = make_dummy_list(32)
	
	lerp_direction = -1
	set_participantList(dummyList)

# Helpers #####################################################
func set_participantList(new_list) -> void:
	participantList = new_list

func make_dummy_list(length) -> Array:
	var list : Array = []
	for i in range (length):
		var instPlayer : PickleballPlayer = PickleballPlayer.new("Player #" + str(i))
		list.append(instPlayer)
	
	return list
