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
var listBuyround = []
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
	
	# instantiate a game, get resource if there's no packed scene
	if !packedPickleballGame: 
		packedPickleballGame = ResourceLoader.load_threaded_get(PATH_PICKLEBALLGAME)
		print("packedPickleballGame packed")
	
	
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
	
	# inserting list
	queued_injection_from_listPlayers(game_)
	
	# setup next permutation
	mediatedFisherYates_playerShuffle()

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
		buyRound_text_ += buy_players_.playerName + ", "
	game.nodeBuyRoundLabel.text = buyRound_text_
	
	# Match is full at this point, replenish listPlayers
	for active_player_ in playerQueue_:
		listPlayers.append(active_player_)

func mediatedFisherYates_playerShuffle():
	#var deferredQueue_ = []
	var shuffledListPlayers_ = []
	
	# arranges playerList in a seeded pattern
	# tries to prevent players from playing together repeatedly by preventing an odd slot from being the same as it's previous
	for gameSlot_ in range(ruleset.playerSlots):
		# Even Slots take random playerfrom the player List
		if gameSlot_ % 2 == 0:
			var popTarget_ = floor(randf()*( listPlayers.size()-1 ))
			shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))
		else:
			for next_player_ in listPlayers:
				if not (shuffledListPlayers_.back().playerBinaryLedger & next_player_.playerBinaryID):
					# Not in ledger, valid pair
					shuffledListPlayers_.back().playerBinaryLedger += next_player_.playerBinaryID
					next_player_.playerBinaryLedger += shuffledListPlayers_.back().playerBinaryID
					shuffledListPlayers_.append(listPlayers.pop_at(listPlayers.find(next_player_)))
					break
				# In ledger, invalid pair
				
	
	#for gameSlot_ in range(ruleset.playerSlots):
		## every even slot we simply insert
		#if gameSlot_ % 2 == 0:
			#if !(deferredQueue_.is_empty()):
				#shuffledListPlayers_.append(deferredQueue_.pop_front())
			#else:
				#var popTarget_ = floor(randf() * listPlayers.size())
				#shuffledListPlayers_.append(listPlayers.pop_at(popTarget_))
		#else: # odd slots are mediated
			#for deferred_player_ in deferredQueue_:
				#if shuffledListPlayers_.back().playerBinaryLedger & deferred_player_.playerBinaryID:
					## player is in the ledger
					#continue
				#else:
					## player is in NOT the ledger, valid!
					#shuffledListPlayers_.back().playerBinaryLedger ++ deferred_player_.playerBinaryID
					#shuffledListPlayers_.append(deferredQueue_[deferredQueue_.find(deferred_player_)].pop())
					#break
			#for next_player_ in listPlayers:
				#if shuffledListPlayers_.back().playerBinaryLedger & next_player_.playerBinaryID:
					## player is in the ledger
					#continue
				#else:
					## player is in NOT the ledger, valid!
					#shuffledListPlayers_.back().playerBinaryLedger ++ next_player_.playerBinaryID
					#shuffledListPlayers_.append(deferredQueue_[deferredQueue_.find(next_player_)].pop())
					#break

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
