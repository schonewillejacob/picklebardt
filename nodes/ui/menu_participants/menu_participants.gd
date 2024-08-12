extends LerpContainer

## Uses a gui to solicit player names.
# 	uses this to provide an Array of PickleballPlayer objects
#   PickleballPlayer objects must be assigned an int that has a unique binary representation w/ constructor.

# served list of Players.
var participantList : Array = []

signal AddPlayer


# Virtuals ####################################################
func _ready() -> void:
	lerpDirection = -1
	var dummyList_ : Array = make_dummy_list(20)
	set_participantList(dummyList_)



# Signals #####################################################
func _on_addPlayer_pressed():
	pass



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
