extends LerpContainer
# Splash menus

signal ManageParticipants

func _ready():
	lerp_direction = 1
	position_target = position_in_place

# Signals #####################################################
func _on_change_rules_pressed():
	pass # Replace with function body.


func _on_generate_bracket_pressed():
	pass # Replace with function body.

func _on_manage_participants_pressed():
	lerp_direction = -1
	emit_signal("ManageParticipants")
	emit_signal("FadeOut")

func _on_options_pressed():
	pass # Replace with function body.

# Helpers #####################################################
