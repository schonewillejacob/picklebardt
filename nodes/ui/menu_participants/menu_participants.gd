extends LerpContainer
# This should be empty, we simply use a dummy list for the teams at the moment.
#
# This script/node is here for future use, implementing a dynamic list of member names.



var participantList = []

func _ready():
	lerp_direction = -1
	
	#TEMP
	var dummyList = make_dummy_list(20)
	set_players(dummyList)
	#TEMP

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
