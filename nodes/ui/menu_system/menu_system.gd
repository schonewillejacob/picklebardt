extends LerpContainer

# Stays present menu-to-menu
# via swap_to method in gui.gd


@onready var exitBufferTimer = $VBoxContainer/systemButtons/End/quitTimer
@onready var backBufferTimer = $VBoxContainer/systemButtons/End/disableTimer
@onready var endSound        = $VBoxContainer/systemButtons/endSound

@onready var acceptButton : BaseButton = $VBoxContainer/systemButtons/Accept
@onready var backButton   : BaseButton = $VBoxContainer/systemButtons/Back
@onready var endButton    : BaseButton = $VBoxContainer/systemButtons/End

signal OnAccept
signal OnBack
signal OnEnd



# Virtuals ####################################################
func _ready():
	lerpDirection = 1



# Signals #####################################################
func _on_end_pressed():
	endButton.disabled = true
	OnEnd.emit()

func _on_back_pressed():
	OnBack.emit()

func _on_accept_pressed():
	OnAccept.emit()


func _on_disable_timer_timeout() -> void:
	endButton.disabled = false

func _on_quit_timer_timeout() -> void:
	get_tree().quit()


# Helpers #####################################################
func request_to_focus_menu():
	if endButton.visible == false:
		backBufferTimer.grab_focus()
	else:
		endButton.grab_focus()

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
