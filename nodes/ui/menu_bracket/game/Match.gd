extends MarginContainer
class_name Match

# Holds Players

@onready var nodePlayerLabel_0 : Label = $GridContainer/player_0
@onready var nodePlayerLabel_1 : Label = $GridContainer/player_1
@onready var nodePlayerLabel_2 : Label = $GridContainer/player_2
@onready var nodePlayerLabel_3 : Label = $GridContainer/player_3

# Virtuals ####################################################
#func _init() -> void:
#func _ready() -> void:
#func _process(delta: float) -> void:


# Signals #####################################################


# Helpers #####################################################
func get_player_labels_nodes() -> Array:
	return [nodePlayerLabel_0,nodePlayerLabel_1,nodePlayerLabel_2,nodePlayerLabel_3]
