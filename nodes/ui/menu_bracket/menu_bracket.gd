extends LerpContainer

# Root players > swaps > Permutation 1 > swaps > Permutation 2 > swaps > ... > Permutation n
# takes a RuleSet and list of Player(s)

# instancing
const PATH_PICKLEBALLGAME : String = "res://nodes/ui/menu_bracket/game/PickleballGame.tscn"
var packedPickleballGame : PackedScene
# PickleballGame target destination
@onready var nodeGameColumn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
# rules
var ruleset : RuleSet = null
var listPlayers = []
var gameCount : int = 0



# Virtuals ####################################################
# Signals #####################################################
func _on_nextRound_pressed() -> void:
	generate_game()



# Helpers #####################################################
func clear_games():
	var children_ = nodeGameColumn.get_children()
	for game_ in children_:
		game_.queue_free()
	gameCount = 0

func generate_game() -> void:
	# Pack Pickleball PackedScene
	if !validate_rules(): return
	# readies packedPickleballGame loading
	if !get_valid_pathhashed_threadresource(PATH_PICKLEBALLGAME): return
	# runs, once, if there's no packed scene
	if !packedPickleballGame: 
		if ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) == 3: # Success
			packedPickleballGame = ResourceLoader.load_threaded_get(PATH_PICKLEBALLGAME)
		else:
			push_error("ResourceLoader.load_threaded_get_status(PATH_PICKLEBALLGAME) != THREAD_LOAD_LOADED")
	else:
		push_warning("packedPickleballGame exists")
	
	# creating PickleballGame instance
	gameCount += 1 # shortcut for naming
	var game_ : PickleballGame = packedPickleballGame.instantiate()
	game_.name = "Game-"+str(gameCount)
	game_.matchCount = 4
	
	# Parenting PickleballGame instance 
	if game_.get_parent():
		game_.get_parent().remove_child(game_)
	nodeGameColumn.add_child(game_)
	game_.set_owner(nodeGameColumn)

func set_players(new_list) -> void:
	listPlayers = new_list

func get_valid_pathhashed_threadresource(_path) -> bool:
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
