extends LerpContainer

## This script/node is here for future use, implementing a dynamic list of member names

# served list of Players.
var participantList : Array = []

func _ready() -> void:
	# This should be empty, we simply use a dummy list for the teams at the moment
	var dummyList_ = make_dummy_list(23)
	
	lerpDirection = -1
	set_participantList(dummyList_)

# Helpers #####################################################
func set_participantList(new_list) -> void:
	participantList = new_list

func make_dummy_list(length) -> Array:
	var list_ : Array = []
	for i in range (length):
		var instPlayer_ : PickleballPlayer = PickleballPlayer.new("Player #" + str(i))
		list_.append(instPlayer_)
	
	return list_
