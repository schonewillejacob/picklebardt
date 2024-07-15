extends LerpContainer
# Splash screen, prototyping menus:


@onready var exitBufferTimer = $vbox/systemButtons/End/endTimer
@onready var endSound = $endSound

func _ready():
	modulate.a = 1
	position_target = position_in_place

# Signals #####################################################
func _on_change_rules_pressed():
	pass # Replace with function body.
	
func _on_end_pressed():
	#play sound
	endSound.play()
	exitBufferTimer.start()

func _on_end_timer_timeout():
	get_tree().quit()

func _on_generate_bracket_pressed():
	pass # Replace with function body.

func _on_manage_participants_pressed():
	toggle_position_target()

func _on_options_pressed():
	pass # Replace with function body.

# Helpers #####################################################
