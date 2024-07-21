extends CanvasLayer

@onready var menu_home         : LerpContainer = $menuHome
@onready var menu_participants : LerpContainer = $menuParticipants
@onready var menu_bracket      : LerpContainer = $menuBracket
@onready var menu_system       : HBoxContainer = $menuSystem

func _ready():
	if menu_home.has_signal("ManageParticipants"):
		menu_home.ManageParticipants.connect(_on_home_manageParticipants)

# Signals #####################################################
func _on_home_manageParticipants():
	menu_participants.lerp_direction = 1
	menu_home.lerp_direction = -1


func _on_home_generateBracket():
	menu_bracket.lerp_direction = 1
	menu_home.lerp_direction = -1


func _on_system_onEnd():
	menu_system.endSound.play()
	menu_system.exitBufferTimer.start()
# Helpers #####################################################
