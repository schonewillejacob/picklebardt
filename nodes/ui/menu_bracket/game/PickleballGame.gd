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
@onready var nodeBuyRoundLabel : Label = $VBoxContainer/BuyRound/VBoxContainer/BuyRoundTitle
@onready var nodeMatchTitle : Label = $VBoxContainer/MatchTitle


# How many matches to place per game
var matchCount : int



# Virtuals ####################################################
func _init(match_count : int = 1) -> void:
	matchCount = match_count

func _ready() -> void:
	var game_number_string_ : String = str(get_parent().get_children().size())
	nodeMatchTitle.text =  "Game " + game_number_string_
	nodeBuyRoundLabel.text = "Buy Round"
	
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
	
	print(playerLabels_)
	return playerLabels_

func load_valid_pathhashed_threadresource(_path) -> bool:
	var loadstatus = null
	# start threaded request
	ResourceLoader.load_threaded_request(_path)
	# processing request
	while loadstatus != 3:
		loadstatus = ResourceLoader.load_threaded_get_status(_path)
		# validate pickleball game resource
		if loadstatus == 0:
			push_error("ResourceLoader.load_threaded_get_status("+_path+") == THREAD_LOAD_INVALID_RESOURCE")
			return false
		if loadstatus == 2:
			push_error("ResourceLoader.load_threaded_get_status("+_path+") == THREAD_LOAD_FAILED")
			return false
	# loadstatus must be == 3
	return true

func validate_matches() -> bool:
	if nodeMatchContainer == null:
		push_error("nodeMatchContainer == null")
		return false
		
	if !load_valid_pathhashed_threadresource(PATH_MATCH):
		push_error("load_valid_pathhashed_threadresource(PATH_MATCH) failed")
		return false
	
	return true

