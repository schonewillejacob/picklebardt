extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n
# Takes a ruleset and players, then makes an effort to distribute play equally

@onready var nodeGameColumn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
var listPlayers = []
var gameCount : int = 0
@export var ruleset : RuleSet = null


# Signals #####################################################
func _on_nextGame_pressed() -> void:
	pass # Replace with function body.


# Helpers #####################################################
func generate_game():
	# guard clauses
	if !validate_game(): return
	
	gameCount += 1
	var nextGame : PickleballGame = PickleballGame.new(ruleset.courtsAvailable)
	nextGame.name = "Game-"+str(gameCount)
	nodeGameColumn.add_child(nextGame)
	
	# TODO "Game-#" nodes can't access their GridContainer children
	print_tree_pretty()

func set_players(new_list):
	listPlayers = new_list

# All manner of RuleSet, Player, etc. validation
func validate_game():
	# Type safety in rules
	if !(ruleset is RuleSet || ruleset == null ):
		push_error("Bad ruleset")
		return false
	# Checking player count
	if (listPlayers.size() < ruleset.CourtSize):
		push_error("Not enough players to fill a court, <"+str(ruleset.CourtSize))
		return false
		
	return true
