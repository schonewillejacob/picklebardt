extends LerpContainer
# TODO enable manageParticipants and changeRules


# Menus for navigating between submenus
# Loosely coupled with main/gui

signal ManageParticipants
signal GenerateBracket
signal ChangeRules



# Virtuals ####################################################
func _ready():
	lerp_direction = 1
	position_target = position_in_place
	var newText = "version " + ProjectSettings.get_setting("application/config/version")
	$vbox/version.set_text(newText)



# Signals #####################################################
func _on_change_rules_pressed():
	emit_signal("ChangeRules")

func _on_generate_bracket_pressed():
	emit_signal("GenerateBracket")

func _on_manage_participants_pressed():
	emit_signal("ManageParticipants")



# Helpers #####################################################
