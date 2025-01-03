## Takes a RuleSet and list of Player(s) and outputs a seeded pickleball game
extends LerpContainer


signal GenerateGame
signal BadPairing

# instancing
const PATH_PICKLEBALLGAME : String = "res://nodes/ui/menu_bracket/game/PickleballGame.tscn"
var packedPickleballGame : PackedScene
# PickleballGame target destination
@onready var nodeGameColumn : VBoxContainer = $sideMargin/VBoxContainer/GameScroller/GameColumn
@onready var node_next_round_button : Button = $sideMargin/VBoxContainer/nextRound
# rules
var ruleset : RuleSet = null
var listPlayers = []
var gameCount : int = 0



# Virtuals ####################################################
# Signals #####################################################
func _on_nextRound_pressed() -> void:
	# Seeded permutate to a new game
	generate_game()



# Helpers #####################################################
func clear_games():
	gameCount = 0
	var children_ = nodeGameColumn.get_children()
	for game_ in children_: game_.queue_free()
	for player_ in listPlayers: player_.clear_ledger()

func generate_game():
	# Packing Pickleball PackedScene
	if !validate_rules(): return
	# readies packedPickleballGame loading
	if !load_valid_pathhashed_threadresource(PATH_PICKLEBALLGAME): return
	
	print(ruleset)
	
	# instantiate a game, get resource if there's no packed scene
	if !packedPickleballGame: 
		packedPickleballGame = ResourceLoader.load_threaded_get(PATH_PICKLEBALLGAME)
		("packedPickleballGame packed")
	
	# SHUFFLING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	mediatedFisherYates_playerShuffle() 
	# SHUFFLING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	# creating PickleballGame instance
	gameCount += 1 # shortcut for naming
	var game_ : PickleballGame = packedPickleballGame.instantiate()
	game_.name = "Game-"+str(gameCount)
	game_.matchCount = min(ruleset.courtsAvailable,floor(listPlayers.size()/ruleset.courtSize))
	game_.courtSize = ruleset.courtSize
	
	# Parenting PickleballGame instance 
	if game_.get_parent():
		game_.get_parent().remove_child(game_)
	nodeGameColumn.add_child(game_)
	game_.set_owner(nodeGameColumn)
	
	#game.focus
	
	# inserting list
	queued_injection_from_listPlayers(game_)

# Takes listPlayers, injects into the matches and buyround, maintaining order
func queued_injection_from_listPlayers(game : PickleballGame):
	var playerQueue_ : Array = []
	
	# search a PickleballGame for Match(es)...
	for match_ in game.nodeMatchContainer.get_children():
		# search a Match for Labels...
		for player_label_ : Label in match_.get_player_label_nodes():
			var player_ : PickleballPlayer = listPlayers.pop_front()
			player_label_.text = player_.playerName
			playerQueue_.append(player_)
	
	# fill buy round label
	# TODO swap to button generation
	var buyRound_text_ : String = ""
	for buy_players_ in listPlayers:
		if buyRound_text_ != "": buyRound_text_ += ", "
		buyRound_text_ += buy_players_.playerName
	game.nodeBuyRoundLabel.text = buyRound_text_
	
	# Match is full at this point, replenish listPlayers
	for active_player_ in playerQueue_:
		listPlayers.append(active_player_)

func FisherYates_playerShuffle():
	# dumb as rocks shuffling function
	var new_queue = []
	
	while(listPlayers.size() != 0):
		new_queue.append( listPlayers.pop_at(floor(randf()*listPlayers.size())) )
	
	listPlayers = new_queue


# Arranges playerList in a (seeded) Fisher-Yates Shuffle, with lax replacements on repeat partnership detection
# BEST-EFFORT prevent ODD players  repeatedly via binary operators
# Destructive
func mediatedFisherYates_playerShuffle():
	var shuffledListPlayers_ = []
	# v this keeps track of the front of the list. Hitting 0 means the buy round size is lower then the court's capacity.
	var sizeBuyPlayers_ = clamp(listPlayers.size() - ruleset.playerSlots, 0, ruleset.playerSlots) # Safety against Buyrounds greater then # court slots
	var popTarget_ : int
	#const BINARY_FULL_LISTPLAYERS = 0
	
	var totalSlots_ = min(ruleset.playerSlots,listPlayers.size())
	for gameSlot_ in range(totalSlots_):
		sizeBuyPlayers_ = clamp(sizeBuyPlayers_-1,0,abs(sizeBuyPlayers_))
		
		popTarget_ = 0
		
		# Slot Zero is simply filled
		if gameSlot_ == 0:
			if sizeBuyPlayers_:
				popTarget_ = floor((randf())*(sizeBuyPlayers_))
			else:
				popTarget_ = floor((randf())*(listPlayers.size()-1))
			popTarget_ = clamp(popTarget_,0,abs(popTarget_))
			
			shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))                                       # INJECTION
			
			continue
		
		# Even Slots take random player from the player List
		if gameSlot_ % 2 == 0:
			if sizeBuyPlayers_: # Restricts to previous buy round 
				popTarget_ = floor((randf())*(sizeBuyPlayers_-1))
				popTarget_ = clamp(popTarget_,0,abs(popTarget_))
				
				shuffledListPlayers_.back().push_to_playerBinaryLedger(listPlayers[popTarget_].playerBinaryID)
				listPlayers[popTarget_].push_to_playerBinaryLedger(shuffledListPlayers_.back().playerBinaryID)
				shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))                                   # INJECTION
			else: # full player list
				popTarget_ = floor((randf())*(listPlayers.size()-1))
				popTarget_ = clamp(popTarget_,0,abs(popTarget_))
				
				shuffledListPlayers_.back().push_to_playerBinaryLedger(listPlayers[popTarget_].playerBinaryID)
				listPlayers[popTarget_].push_to_playerBinaryLedger(shuffledListPlayers_.back().playerBinaryID)
				shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))                                   # INJECTION
			continue
		
		# Odd slots search at shuffledListPlayers_.back() for a pair
		var flag_pairFound : bool = false
		for next_player_ in listPlayers: # this checking from the front will naturally bias towards Buy Round players injection...
			if shuffledListPlayers_.back().playerBinaryLedger & next_player_.playerBinaryID == 0:
				print("pair found: "+str(shuffledListPlayers_.back().playerName)+" & "+str(next_player_.playerName))
				# Not in ledger, valid pair
				shuffledListPlayers_.back().push_to_playerBinaryLedger(next_player_.playerBinaryID)
				next_player_.push_to_playerBinaryLedger(shuffledListPlayers_.back().playerBinaryID)
				shuffledListPlayers_.append(listPlayers.pop_at(listPlayers.find(next_player_)))           # INJECTION
				flag_pairFound = true
				break
		if flag_pairFound: 
			continue
		
		# No valid pair found, gets more likely with higher Game counts, nodeGameColumn.size()
		# so pick one at random
		popTarget_ = floor((randf())*( listPlayers.size()-1 ))
		popTarget_ = clamp(popTarget_,0,abs(popTarget_))
		
		
		shuffledListPlayers_.back().push_to_playerBinaryLedger(listPlayers[popTarget_].playerBinaryID)
		listPlayers[popTarget_].push_to_playerBinaryLedger(shuffledListPlayers_.back().playerBinaryID)
		shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))                                       # INJECTION
		push_warning("No pair found for "+shuffledListPlayers_.back().playerName+", playerBinaryID: 0b"+ String.num_int64(shuffledListPlayers_.back().playerBinaryID,2))
		
		#check to see if everyone has been pulled.
	
	# Game slots are filled at this point, replenish listPlayers
	for buy_player_ in listPlayers:
		shuffledListPlayers_.append(buy_player_)
	set_playerList(shuffledListPlayers_)

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

func request_to_focus_menu():
	node_next_round_button.grab_focus()

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
