extends LerpContainer

# This script/node is here for future use, implementing a dynamic list of member names

# Holds 
var participantList = []

func _ready():
	# This should be empty, we simply use a dummy list for the teams at the moment
	var dummyList = make_dummy_list(20)
	
	lerp_direction = -1
	set_players(dummyList)

# Helpers #####################################################
func set_players(new_list):
	print("menu_participants.gd:\n"+str(new_list)+"\n")
	participantList = new_list

func make_dummy_list(length):
	var list = []
	for i in range (length):
		var instPlayer : PickleballPlayer = PickleballPlayer.new("player_" + str(i))
		list.append(instPlayer)
	
	return list
