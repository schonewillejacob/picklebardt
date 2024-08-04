extends Control
class_name PickleballGame

# Holds a number of matches to be rendered by menu_bracket
#    menu_bracket/sideMargin/VBoxContainer/GameScroller/GameColumn

# Match.tscn instancing
# We don't adjust these in real time, so pooling isn't needed
const PATH_MATCH : String = "res://nodes/ui/menu_bracket/game/Match.tscn"
var packedMatch : PackedScene
# Match target destination
@onready var nodeMatchContainer : GridContainer = $MatchContainer

# How many matches to place per game
var matchCount : int



# Virtuals ####################################################
func _init(match_count : int = 1) -> void:
	matchCount = match_count

func _ready() -> void:
	# setting up threaded loading
	ResourceLoader.load_threaded_request(PATH_MATCH)
	
	# finding grid for the matches
	if nodeMatchContainer == null: 
		push_error("create_matches() failed: nodeMatchContainer == null")
	else:
		create_matches()


# Helpers #####################################################
func create_matches():
	# validate matches
	if nodeMatchContainer == null:
		push_error("nodeMatchContainer == null")
	
	packedMatch = ResourceLoader.load_threaded_get(PATH_MATCH)
	for i in matchCount:
		var instMatch = packedMatch.instantiate()
		nodeMatchContainer.add_child(instMatch) 
