extends LerpContainer
# This should be empty, we simply use a dummy list for the teams at the moment.
#
# This script/node is here for future use, implementing a dynamic list of member names.



var participantList = []

func _ready():
	lerp_direction = -1
	
	var dummyList = []
	
	
	for i in range (20):
		var instPlayer : PickleballPlayer = PickleballPlayer.new()
		dummyList.append(instPlayer)
	set_players(dummyList)

# Helpers #####################################################
func set_players(new_list):
	print("menu_participants.gd:\n"+str(new_list)+"\n")
	participantList = new_list
