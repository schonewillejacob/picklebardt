extends HBoxContainer

@onready var exitBufferTimer = $End/endTimer
@onready var endSound = $endSound


# play sound and quit
func _on_end_pressed():
	endSound.play()
	exitBufferTimer.start()

func _on_end_timer_timeout():
	get_tree().quit()
