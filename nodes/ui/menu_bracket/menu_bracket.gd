extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n
# Takes a ruleset and players, then makes an effort to distribute play equally

@onready var nodeGameColumn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
var listPlayers = []
@export var ruleset : RuleSet = null


# Signals #####################################################
func _on_next_game_pressed() -> void:
	pass # Replace with function body.



# Helpers #####################################################
func generate_game():
	if !validate_game(): return
	nodeGameColumn.add_child(PickleballGame.new(ruleset.courtsAvailable))
	
func set_players(new_list):
	listPlayers = new_list

# All manner of RuleSet, Player, etc. validation
func validate_game():
	# Type safety in rules
	if !(ruleset is RuleSet || ruleset == null ):
		push_error("Bad ruleset")
		return false
	# Checking player count
	if (listPlayers.size() < ruleset.COURT_SIZE):
		push_error("Not enough players to fill a court, <"+str(ruleset.COURT_SIZE))
		return false
		
	return true
