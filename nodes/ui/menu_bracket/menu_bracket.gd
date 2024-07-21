extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n

var recieved_players = []

# Helpers #####################################################
func set_players(new_list):
	recieved_players = new_list
