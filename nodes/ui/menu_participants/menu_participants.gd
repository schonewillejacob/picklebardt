extends LerpContainer
# This should be empty, we simply use a dummy list for the teams at the moment.
#
# This script/node is here for future use, implementing a dynamic list of member names.



var participant_list = []

func _ready():
	lerp_direction = -1
	
	var dummy_list = []
	for i in range (20):
		dummy_list.append("pickleball player "+str(i+1))
	set_players(dummy_list)

# Helpers #####################################################
func set_players(new_list):
	participant_list = new_list
