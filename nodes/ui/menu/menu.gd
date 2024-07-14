extends VBoxContainer
# Splash screen, prototyping menus:


@onready var exitBufferTimer = $expandingOptionsHeader/End/endTimer
@onready var endSound = $expandingOptionsHeader/End/endSound

# Virtuals ####################################################
func _ready():
	# Connecting
	exitBufferTimer.timeout.connect(_on_exitBufferTimer)

# Signals #####################################################
func _on_end_pressed():
	#play sound
	endSound.play()
	exitBufferTimer.start()

func _on_options_pressed():
	pass # Replace with function body.

func _on_exitBufferTimer():
	get_tree().quit()

# Helpers #####################################################
