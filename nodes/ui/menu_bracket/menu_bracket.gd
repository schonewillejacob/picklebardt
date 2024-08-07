extends LerpContainer
## Root players > swaps > Permutation 1 > swaps > Permutation 2 > swaps > ... > Permutation n
## takes a RuleSet and list of Player(s)

signal GenerateGame

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

func generate_game():
	# Packing Pickleball PackedScene
	if !validate_rules(): return
	# readies packedPickleballGame loading
	if !load_valid_pathhashed_threadresource(PATH_PICKLEBALLGAME): return
	# instantiate a game, loads if there's no packed scene
	if !packedPickleballGame: 
		packedPickleballGame = ResourceLoader.load_threaded_get(PATH_PICKLEBALLGAME)
	else:
		push_warning("packedPickleballGame exists")
	
	var game_ : PickleballGame = packedPickleballGame.instantiate()
	
	# creating PickleballGame instance
	gameCount += 1 # shortcut for naming
	game_.name = "Game-"+str(gameCount)
	game_.matchCount = 4
	
	# Parenting PickleballGame instance 
	if game_.get_parent():
		game_.get_parent().remove_child(game_)
	nodeGameColumn.add_child(game_)
	game_.set_owner(nodeGameColumn)
	
	# inserting list
	inject_simple_listPlayers(game_)
	
	return game_

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

func inject_simple_listPlayers(game_ : PickleballGame):
	var playerQueue_ : Array = []
	
	for match_ in game_.nodeMatchContainer.get_children():
		for player_label_ : Label in match_.get_player_label_nodes():
			var player_ : PickleballPlayer = listPlayers.pop_front()
			player_label_.text = player_.playerName
			
			playerQueue_.append(player_)
	# fill buy round box
	var buyRound_text : String = ""
	for buy_players_ in listPlayers:
		buyRound_text += buy_players_.playerName + ", "
	
	game_.nodeBuyRoundLabel.text = buyRound_text
	
	# Match is full at this point, replenish listPlayers
	for active_player_ in playerQueue_:
		listPlayers.append(active_player_)

func inject_shuffle_listPlayers(game_ : PickleballGame):
	var playerQueue_ : Array = []
	
	for match_ in game_.nodeMatchContainer.get_children():
		for player_label_ : Label in match_.get_player_label_nodes():
			var player_ : PickleballPlayer = listPlayers.pop_front()
			player_label_.text = player_.playerName
			playerQueue_.append(player_)
	# Match is full at this point, replenish listPlayers
	
	for active_player_ in playerQueue_:
		listPlayers.append(active_player_)
	

func set_playerList(new_list) -> void:
	listPlayers = new_list

func validate_rules() -> bool:
	# type safety in rules
	if !(ruleset is RuleSet || ruleset == null ):
		push_error("Bad ruleset")
		return false
	
	# checking player count, must fill a court
	if (listPlayers.size() < ruleset.courtSize):
		push_error("Not enough players to fill a court, <"+str(ruleset.courtSize))
		return false
	
	return true
