extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n
# Takes a ruleset and players, then makes an effort to distribute play equally

var recieved_players = []
@export var ruleset : RuleSet = null

@onready var template_game = $sideMargin/GameScroller/mainColumn/game1



# Signals #####################################################
func _on_next_game_pressed() -> void:
	pass # Replace with function body.



# Helpers #####################################################
func set_players(new_list):
	recieved_players = new_list

func generate_game():
#	Type safety in rules
	if !(ruleset is RuleSet):
		pass
	
	


