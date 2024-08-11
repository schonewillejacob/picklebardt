extends Control
class_name PickleballGame

## Holds a number of matches to be rendered by menu_bracket
##    menu_bracket/sideMargin/VBoxContainer/GameScroller/GameColumn
## menu_bracket orchestrates behaviour here.

# Match.tscn instancing
# We don't adjust these in real time, so pooling isn't needed
const PATH_MATCH : String = "res://nodes/ui/menu_bracket/game/Match.tscn"
var packedMatch : PackedScene
# Match target destination
@onready var nodeMatchContainer : GridContainer = $VBoxContainer/MatchContainer
@onready var nodeBuyRoundLabel : Label = $VBoxContainer/BuyRound/VBoxContainer/BuyRoundList
@onready var nodeMatchTitle : Label = $VBoxContainer/MatchTitle


# How many matches to place per game
var matchCount : int



# Virtuals ####################################################
func _init(match_count : int = 1) -> void:
	matchCount = match_count

func _ready() -> void:
	var game_number_string_ : String = str(get_parent().get_children().size())
	nodeMatchTitle.text =  "Game " + game_number_string_
	
	# finding grid for the matches
	if nodeMatchContainer == null: 
		push_error("create_matches() failed: nodeMatchContainer == null")
	else:
		create_matches()



# Helpers #####################################################
func create_matches():
	if !validate_matches(): return
	
	packedMatch = ResourceLoader.load_threaded_get(PATH_MATCH)
	for i in matchCount:
		var instMatch = packedMatch.instantiate()
		nodeMatchContainer.add_child(instMatch) 

func get_all_playerLabels() -> Array:
	var playerLabels_ = []
	for child in nodeMatchContainer.get_children():
		if child is Label:
			playerLabels_.append(child)
	
	return playerLabels_

func load_valid_pathhashed_threadresource(resource_path) -> bool:
	var loadStatus_ = null
	# start threaded request
	ResourceLoader.load_threaded_request(resource_path)
	# processing request
	while loadStatus_ != 3:
		loadStatus_ = ResourceLoader.load_threaded_get_status(resource_path)
		# validate pickleball game resource
		if loadStatus_ == 0:
			push_error("ResourceLoader.load_threaded_get_status("+resource_path+") == THREAD_LOAD_INVALID_RESOURCE")
			return false
		if loadStatus_ == 2:
			push_error("ResourceLoader.load_threaded_get_status("+resource_path+") == THREAD_LOAD_FAILED")
			return false
	# loadStatus_ must be == 3
	return true

func validate_matches() -> bool:
	if nodeMatchContainer == null:
		push_error("nodeMatchContainer == null")
		return false
		
	if !load_valid_pathhashed_threadresource(PATH_MATCH):
		push_error("load_valid_pathhashed_threadresource(PATH_MATCH) failed")
		return false
	
	return true

