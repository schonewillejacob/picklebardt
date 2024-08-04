extends LerpContainer

# Root players > Permutation 1 > Permutation 2 > ... > Permutation n
# Takes a ruleset and players, then makes an effort to distribute play equally

# instancing
const PATH_PICKLEBALLGAME : String = "res://nodes/ui/menu_bracket/game/PickleballGame.tscn"
var packedPickleballGame : PackedScene
# PickleballGame target destination
@onready var nodeGameColumn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
# Rules
@export var ruleset : RuleSet = null
var listPlayers = []
var gameCount : int = 0



# Virtuals ####################################################
# Signals #####################################################
func _on_nextGame_pressed() -> void:
	generate_game()



# Helpers #####################################################
func generate_game() -> void:
	
	# guard clauses
	if !validate_rules(): return
	
	if !validate_and_start_request(): return
	
	if !packedPickleballGame: # runs, once, if there's no packed scene
		if ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) == 3: # Success
			packedPickleballGame = ResourceLoader.load_threaded_get(PATH_PICKLEBALLGAME)
		else:
			push_error("ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) != THREAD_LOAD_LOADED")
	else:
		push_error("packedPickleballGame exists")
	
	# Probably successful, this is for naming.
	gameCount += 1
	
	var nextGame : PickleballGame = packedPickleballGame.instantiate()
	nextGame.name = "Game-"+str(gameCount)
	nextGame.matchCount = 4
	nodeGameColumn.add_child(nextGame)

func set_players(new_list) -> void:
	listPlayers = new_list

func validate_and_start_request() -> bool:
	# Start threaded request
	ResourceLoader.load_threaded_request(PATH_PICKLEBALLGAME)
	
	# processing request
	var loadstatus_pickleballGamePacked = ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME)
	while loadstatus_pickleballGamePacked != 3:
		loadstatus_pickleballGamePacked = ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME)
		# validate pickleball game resource
		if loadstatus_pickleballGamePacked == 0:
			push_error("ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) == THREAD_LOAD_INVALID_RESOURCE")
			return false
		if loadstatus_pickleballGamePacked == 2:
			push_error("ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) == THREAD_LOAD_FAILED")
			return false
	
	# loadstatus_pickleballGamePacked must be == 3
	return true

func validate_rules() -> bool:
	# type safety in rules
	if !(ruleset is RuleSet || ruleset == null ):
		push_error("Bad ruleset")
		return false
	
	# checking player count, must fill a court
	if (listPlayers.size() < ruleset.CourtSize):
		push_error("Not enough players to fill a court, <"+str(ruleset.CourtSize))
		return false
	

	
	return true
