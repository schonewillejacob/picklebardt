extends CanvasLayer

@onready var menu_home         : LerpContainer = $menuHome
@onready var menu_participants : LerpContainer = $menuParticipants
@onready var menu_bracket      : LerpContainer = $menuBracket
@onready var menu_system       : LerpContainer = $menuSystem


# Signals #####################################################
func _on_home_changeRules():
	menu_system.endSound.play()
	

func _on_home_manageParticipants():
	swap_to(menu_participants)
	menu_system.to_back()

func _on_home_generateBracket():
	if menu_participants.participant_list:
		menu_bracket.set_players(menu_participants.participant_list) # pulls players from participant list to generation alogrithm
	
	print("gui.gd:\n"+str(menu_participants.participant_list)+"\n")
	
	swap_to(menu_bracket)
	menu_system.to_back()

func _on_system_onEnd():
	menu_system.endSound.play()
	menu_system.exitBufferTimer.start()
	swap_to(null) # fades all menus away, as the above timer closes the program

func _on_system_onBack():
	swap_to(menu_home)
	menu_system.to_end()

# Helpers #####################################################
func swap_to(swapped_to_lerpcontainer : LerpContainer):
	menu_home.lerp_direction = -1
	menu_bracket.lerp_direction = -1
	menu_participants.lerp_direction = -1
	
	match(swapped_to_lerpcontainer):
		menu_home:
			menu_home.lerp_direction = 1
			pass
		menu_bracket:
			menu_bracket.lerp_direction = 1
			pass
		menu_participants:
			menu_participants.lerp_direction = 1
			pass
