extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n
# Takes a ruleset and players, then makes an effort to distribute play equally

var recieved_players = []
var game = []
var matches_count : int = 0

@export var ruleset : RuleSet = null
@onready var scrollContainer : ScrollContainer = $sideMargin/VBoxContainer/GameScroller
@onready var scrollContainerColummn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
var packed_match = preload("res://nodes/ui/menu_bracket/game/Match.tscn")


# Signals #####################################################
func _on_next_game_pressed() -> void:
	pass # Replace with function body.



# Helpers #####################################################
func set_players(new_list):
	recieved_players = new_list

func generate_game():
#	Type safety in rules
	if !(ruleset is RuleSet || ruleset == null ):
		print("ERROR: Bad ruleset")
		pass
#	Checking player count
	if (recieved_players.size() != ruleset._player_count):
		print("ERROR: player array size not declared count\nrecieved_players.size(): "+str(recieved_players.size())+"\nruleset._player_count: ",str(ruleset._player_count))
		pass
	matches_count = floor((ruleset._player_count - (ruleset._player_count % 4)) / 4.0)
	if !matches_count:
		print("ERROR: 0 matches")
		pass
	
	for m in matches_count:
		scrollContainerColummn.add_child(packed_match.instantiate())
