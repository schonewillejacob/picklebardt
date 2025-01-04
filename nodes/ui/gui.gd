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
@onready var fade_in_rect      : ColorRect = $FadeInRect

var system_buttons : Array[Button] = []

# Virtuals ####################################################
func _ready() -> void:
	connect_system_as_neighbour()
	menu_participants.quickload_list()

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		menu_system.emit_signal("OnBack")



# Signals #####################################################
func _on_home_changeRules():
	swap_to(menu_rules)
	menu_system.to_back()
	menu_rules.request_to_focus_menu()

func _on_home_manageParticipants():
	swap_to(menu_participants)
	menu_system.to_back()
	menu_participants.request_to_focus_menu()

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
	menu_bracket.request_to_focus_menu()

func _on_participants_add_player() -> void: pass

func _on_rules_ruleChanged():
	menu_system.acceptButton.visible = true

func _on_system_onAccept() -> void:
	menu_rules.set_export_ruleset()
	
	menu_system.to_end()
	swap_to(menu_home)

func _on_system_onBack():
	menu_bracket.clear_games()
	menu_participants.create_from_control_nodes()
	menu_participants.quicksave_list()
	menu_rules.set_fields_to_current()
	menu_system.to_end()
	swap_to(menu_home)

func _on_system_onEnd():
	menu_system.endSound.play()
	menu_system.exitBufferTimer.start()
	$FadeInRect.get_node_or_null("AnimationPlayer").play_backwards()
	menu_system.lerpDirection = -1
	swap_to(null) # fades all menus away, as the above timer closes the program



# Helpers #####################################################
func connect_system_as_neighbour():
	#Get the back button
	var _system_back : Button = menu_system.get_node_or_null("VBoxContainer/systemButtons/Back")
	var _system_end  : Button = menu_system.get_node_or_null("VBoxContainer/systemButtons/End")
	if _system_back == null || _system_end == null:
		return false
	
	system_buttons.append(_system_back)
	system_buttons.append(_system_end)
	
	return true

func swap_to(swapped_to_lerpcontainer : LerpContainer):
	menu_home.lerpDirection = -1
	menu_bracket.lerpDirection = -1
	menu_participants.lerpDirection = -1
	menu_rules.lerpDirection = -1
#	menu_system.lerpDirection = -1 is never called, as the menu is persistant
	
	match(swapped_to_lerpcontainer):
		menu_home:
			menu_home.lerpDirection = 1
			menu_home.request_to_focus_menu()
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
