extends CanvasLayer

@onready var menu_home : LerpContainer = $menu_home
@onready var menu_participants : LerpContainer = $menu_participants

func _ready():
	if menu_home.has_signal("ManageParticipants"):
		menu_home.ManageParticipants.connect(_on_home_manageParticipants)


func _on_home_manageParticipants():
	menu_participants.lerp_direction = 1
