extends VBoxContainer
# Splash screen, prototyping menus:

@onready var exitBufferTimer = $expanding_options_header/End/Timer

func _on_end_pressed():
	#play sound
	exitBufferTimer.start(1.5)
	
func _on_exitBufferTimer():
	get_tree().quit()
	pass
