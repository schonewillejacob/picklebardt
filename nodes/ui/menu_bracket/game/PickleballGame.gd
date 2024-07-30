extends Control
class_name PickleballGame

# These nodes are placed into the GameColumn node in menu_bracket

const PATH_MATCH : String = "res://nodes/ui/menu_bracket/game/Match.tscn"
@onready var matchContainer : GridContainer = $MatchContainer
#@export var matchContainer : GridContainer
var matchCount : int


# Virtuals ####################################################
func _init(match_count : int = 1) -> void:
	matchCount = match_count

func _ready() -> void:
	# setting up threaded loading
	ResourceLoader.load_threaded_request(PATH_MATCH)
	
	# finding grid for the matches
	if matchContainer == null: 
		push_error("create_matches() failed: matchContainer == null")
	else:
		create_matches()


# Helpers #####################################################
func create_matches():
	if matchContainer == null:
		push_error("matchContainer == null")
	
	var packedMatch = ResourceLoader.load_threaded_get(PATH_MATCH)
	# TODO matchContainer doesn't exist when instantiated, figure out how to reference downwards w/in a child
	for i in matchCount:
		var instMatch = packedMatch.instantiate()
		matchContainer.add_child(instMatch) 
