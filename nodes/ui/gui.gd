extends CanvasLayer
## Manages the user experience within the app
## Behaviour is used here, but is defined on a per-node basis

# TODO assess assigning menu_* buttons exclusive ButtonGroups
# TODO refactor control nodes naming scheme: menu_<id> -> nodeMenu<Id>

# Menu Control nodes
@onready var menu_bracket      : LerpContainer = $menuBracket
@onready var menu_home         : LerpContainer = $menuHome
@onready var menu_participants : LerpContainer = $menuParticipants
@onready var menu_rules        : LerpContainer = $menuRules
@onready var menu_system       : LerpContainer = $menuSystem


# Virtuals ####################################################
#func _ready() -> void:



# Signals #####################################################
func _on_home_changeRules():
	swap_to(menu_rules)
	menu_system.to_back()

func _on_home_manageParticipants():
	swap_to(menu_participants)
	menu_system.to_back()

func _on_home_generateBracket():
	if !menu_participants.participantList:
		push_error("menu_participants.participantList empty")
	
	if menu_rules.nodeRandomSeedButton.is_pressed(): 
		menu_rules.nodeSeedLineEdit.text = str(hash(randf()))
		menu_rules.set_export_ruleset()
	menu_bracket.listPlayers = menu_participants.participantList.duplicate() # gets fresh Array copy, to be manipulated.
	menu_bracket.ruleset = menu_rules.ruleExport
	
	seed(menu_bracket.ruleset.shuffleSeed)
	menu_bracket.FisherYates_playerShuffle()
	menu_bracket.generate_game()
	
	swap_to(menu_bracket)
	menu_system.to_back()

func _on_system_onAccept() -> void:
	menu_rules.set_export_ruleset()
	
	menu_system.to_end()
	swap_to(menu_home)

func _on_system_onBack():
	menu_bracket.clear_games()
	# menu_rules reset
	menu_rules.set_fields_to_current()
	menu_system.to_end()
	swap_to(menu_home)

func _on_system_onEnd():
	menu_system.endSound.play()
	menu_system.exitBufferTimer.start()
	
	menu_system.lerpDirection = -1
	swap_to(null) # fades all menus away, as the above timer closes the program

func _on_rules_ruleChanged():
	menu_system.acceptButton.visible = true

# Helpers #####################################################
func swap_to(swapped_to_lerpcontainer : LerpContainer):
	menu_home.lerpDirection = -1
	menu_bracket.lerpDirection = -1
	menu_participants.lerpDirection = -1
	menu_rules.lerpDirection = -1
#	menu_system.lerpDirection = -1 is never called, as the menu is persistant
	
	match(swapped_to_lerpcontainer):
		menu_home:
			menu_home.lerpDirection = 1
			pass
		menu_bracket:
			menu_bracket.lerpDirection = 1
			pass
		menu_participants:
			menu_participants.lerpDirection = 1
			pass
		menu_rules:
			menu_rules.lerpDirection = 1
			pass


