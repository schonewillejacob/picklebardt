extends VBoxContainer
# Splash screen, prototyping menus:

var exitBufferTimer: Timer

func _init():
	exitBufferTimer.autostart = false
	exitBufferTimer.wait_time = 1.5
	
	exitBufferTimer.connect("timeout",_on_exitBufferTimer)

func _on_end_pressed():
	exitBufferTimer.start
	
func _on_exitBufferTimer():
	get_tree().quit()
	pass
