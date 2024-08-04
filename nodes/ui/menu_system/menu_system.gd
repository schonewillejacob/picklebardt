extends LerpContainer

# Stays present menu-to-menu
# via swap_to method in gui.gd


@onready var exitBufferTimer = $VBoxContainer/systemButtons/End/endTimer
@onready var endSound = $VBoxContainer/systemButtons/endSound

@onready var acceptButton : BaseButton = $VBoxContainer/systemButtons/Accept
@onready var backButton : BaseButton = $VBoxContainer/systemButtons/Back
@onready var endButton : BaseButton = $VBoxContainer/systemButtons/End

signal onAccept
signal onBack
signal onEnd



# Virtuals ####################################################
func _ready():
	lerp_direction = 1



# Signals #####################################################
func _on_end_pressed():
	onEnd.emit()

func _on_back_pressed():
	to_end()
	onBack.emit()

func _on_accept_pressed():
	to_end()

func _on_end_timer_timeout():
	get_tree().quit()



# Helpers #####################################################
func to_accept():
	backButton.visible = false
	endButton.visible = false
	acceptButton.visible = true
func to_back():
	acceptButton.visible = false
	endButton.visible = false
	backButton.visible = true
func to_end():
	acceptButton.visible = false
	backButton.visible = false
	endButton.visible = true
