extends LerpContainer
# Splash menus

signal ManageParticipants
signal GenerateBracket

func _ready():
	lerp_direction = 1
	position_target = position_in_place



# Signals #####################################################
func _on_change_rules_pressed():
	pass # Replace with function body.

func _on_generate_bracket_pressed():
	emit_signal("GenerateBracket")

func _on_manage_participants_pressed():
	emit_signal("ManageParticipants")



# Helpers #####################################################
