extends MarginContainer
class_name Match
## Displays player names

@onready var nodePlayerGrid : GridContainer = $GridContainer
@onready var nodePlayerLabel_0 : Label = $GridContainer/player_0
@onready var nodePlayerLabel_1 : Label = $GridContainer/player_1
@onready var nodePlayerLabel_2 : Label = $GridContainer/player_2
@onready var nodePlayerLabel_3 : Label = $GridContainer/player_3
@onready var nodeMiddlebandR : ColorRect = $GridContainer/middlebandR

var courtSize : int = 4

# Virtuals ####################################################
#func _init() -> void:
func _ready() -> void:
	if courtSize == 2: pare_to_duos()
#func _process(delta: float) -> void:
# Signals #####################################################



# Helpers #####################################################
func get_player_label_nodes() -> Array:
	var labels = []
	labels.append(nodePlayerLabel_0)
	labels.append(nodePlayerLabel_3)

	if courtSize != 2:
		labels.append(nodePlayerLabel_1)
		labels.append(nodePlayerLabel_2)
	
	return labels

func pare_to_duos():
	nodePlayerGrid.columns = 1
	nodePlayerLabel_1.queue_free()
	nodePlayerLabel_2.queue_free()
	nodeMiddlebandR.queue_free()
	nodePlayerLabel_3.name = "player_1"
	pass
