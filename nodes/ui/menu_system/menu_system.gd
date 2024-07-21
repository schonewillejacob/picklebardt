extends HBoxContainer

@onready var exitBufferTimer = $End/endTimer
@onready var endSound = $endSound

@onready var endButton : BaseButton = $End
@onready var backButton : BaseButton = $Back

signal onBack
signal onEnd

# Signals #####################################################
func _on_end_pressed():
	onEnd.emit()

func _on_back_pressed():
	to_end()
	onBack.emit()

func _on_end_timer_timeout():
	get_tree().quit()


# Helpers #####################################################
func to_back():
	endButton.visible = false
	backButton.visible = true
func to_end():
	endButton.visible = true
	backButton.visible = false
