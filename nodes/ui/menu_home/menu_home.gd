extends LerpContainer


# Menus for navigating between submenus
# Loosely coupled with main/gui

signal ManageParticipants
signal GenerateBracket
signal ChangeRules



# Virtuals ####################################################
func _ready():
	lerpDirection = 1
	positionTarget = positionInPlace
	var newText = "version " + ProjectSettings.get_setting("application/config/version")
	$vbox/version.set_text(newText)
	$vbox/generateBracketHbox/generateBracket.grab_focus()



# Signals #####################################################
func _on_change_rules_pressed():
	ChangeRules.emit()

func _on_generate_bracket_pressed():
	GenerateBracket.emit()

func _on_manage_participants_pressed():
	ManageParticipants.emit()



# Helpers #####################################################
