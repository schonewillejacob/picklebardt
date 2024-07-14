extends VBoxContainer
# Splash screen, prototyping menus:

@onready var exitBufferTimer = $expanding_options_header/End/endTimer
@onready var endSound = $expanding_options_header/End/endSound

func _ready():
	exitBufferTimer.timeout.connect(_on_exitBufferTimer)

func _on_end_pressed():
	#play sound
	endSound.play()
	exitBufferTimer.start()
	
func _on_exitBufferTimer():
	get_tree().quit()
