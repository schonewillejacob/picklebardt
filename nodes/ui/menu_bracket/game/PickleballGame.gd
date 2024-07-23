extends Control
class_name PickleballGame

# These nodes are placed into the GameColumn node in menu_bracket
@onready var matchContainer : GridContainer = $MatchContainer
const PATH_MATCH : String = "res://nodes/ui/menu_bracket/game/Match.tscn"
var matchCount : int

func _init(_matchCount : int = 1) -> void:
	matchCount = _matchCount

func _ready() -> void:
	ResourceLoader.load_threaded_request(PATH_MATCH)
	
	create_matches()

func create_matches():
	var packedMatch = ResourceLoader.load_threaded_get(PATH_MATCH)
	# TODO MatchContainer doesn't exist, figure out how to reference downwards w/in a child
	for i in matchCount:
		var instMatch = packedMatch.instantiate()
		matchContainer.add_child(instMatch) 
