extends LerpContainer



# served list of Players.
var participantList : Array = []

func _ready() -> void:
	# This should be empty, we simply use a dummy list for the teams at the moment
	var dummyList_ = make_dummy_list(23)
	
	lerpDirection = -1
	set_participantList(dummyList_)

# Helpers #####################################################
func make_dummy_list(length) -> Array:
	var list_ : Array = []
	var id_interations_ : int = 0b1
	for i in range (length):
		var instPlayer_ : PickleballPlayer = PickleballPlayer.new("Player #" + str(i+1),id_interations_)
		id_interations_ *= 2
		
		print("playerName = " + instPlayer_.playerName + ", playerBinaryID = " + str(instPlayer_.playerBinaryID) + " / 0b"+ String.num_int64(instPlayer_.playerBinaryID,2))
		list_.append(instPlayer_)
	
	return list_

func set_participantList(new_list) -> void:
	participantList = new_list
