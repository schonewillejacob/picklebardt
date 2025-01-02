extends LerpContainer

## Uses a gui to solicit player names.
# 	Uses this to provide an Array of PickleballPlayer objects
#   PickleballPlayer objects must be assigned an int that has a unique binary 
#	representation w/ constructor.

# served list of Players.
var participantList : Array[PickleballPlayer] = []
var DEBUG_DUMMY : bool = false
var slot_pool : Array[int] = [0]
var slot_ongoing : int = 0
@onready var node_add_player_line_edit : LineEdit = $MarginContainer/VBoxContainer/ColorRect/MarginContainer/menu_participants/HBoxContainer/AddPlayerLineEdit
@onready var packed_player_template : PackedScene = load("res://nodes/ui/menu_participants/player_template.tscn")
@onready var node_player_list : VBoxContainer = $MarginContainer/VBoxContainer/ColorRect/MarginContainer/menu_participants/TabContainer/Players/VBoxContainer

signal AddPlayer


# VIRTUALS #####################################################################
func _ready() -> void:
	lerpDirection = -1



# SIGNALS #####################################################
func _on_add_player_button_pressed() -> void:
	var _new_player_name
	# Manipulate LineEdit.
	if node_add_player_line_edit.text == "": 
		_new_player_name = "Player " + str(slot_ongoing)
		slot_ongoing += 1
	else:
		_new_player_name = node_add_player_line_edit.text
	node_add_player_line_edit.text = ""
	
	# Create player from template.
	var _new_player = packed_player_template.instantiate()
	if _new_player.get_node_or_null(
		"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
		):
		_new_player.get_node_or_null(
		"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
		).text = _new_player_name 
	_new_player.tree_exited.connect(_on_remove_player_button_pressed)
	node_player_list.add_child(_new_player)
	AddPlayer.emit()
	
	

func _on_remove_player_button_pressed() -> void:
	var _total = node_player_list.get_child_count()
	if _total < 1: 
		slot_ongoing = 0
		return

# METHODS #####################################################
func create_from_control_nodes():
	# Get nodes, use names and data for PickleBallPlayer objects
	var _list : Array[PickleballPlayer] = []
	var _id_binary_interation : int = 0b1
	var _name : String = "player"
	for _player in node_player_list.get_children():
		# Guard clause: type
		if _player is not PlayerTemplate: continue
		if _player.get_node_or_null(
			"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
			):
			_name = _player.get_node_or_null(
			"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
			).text
		var _inst_player : PickleballPlayer = PickleballPlayer.new(
			_name,
			_id_binary_interation)
		_id_binary_interation *= 2
		_list.append(_inst_player)
	participantList = _list
	

func make_dummy_list(length) -> Array:
	var list_ : Array = []
	var id_interations_ : int = 0b1
	for i in range (length):
		var instPlayer_ : PickleballPlayer = PickleballPlayer.new("Player #" + str(i+1),id_interations_)
		id_interations_ *= 2
		
		print("playerName = " + instPlayer_.playerName + ", playerBinaryID = " + str(instPlayer_.playerBinaryID) + " / 0b"+ String.num_int64(instPlayer_.playerBinaryID,2))
		list_.append(instPlayer_)
	
	return list_

func set_participantList(new_list) -> void:
	participantList = new_list

func quickload_list():
	var _file = FileAccess.open("user://player_list.dat", FileAccess.READ)
	if _file == null:
		return
	
	var _json_data = JSON.new()
	var error = _json_data.parse(_file.get_as_text())
	if error == OK:
		for _player in _json_data.data:
			var _inst_player_quickload = packed_player_template.instantiate()
			if _inst_player_quickload.get_node_or_null(
				"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
				):
				_inst_player_quickload.get_node_or_null(
				"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
				).text = str(_player)
				
				node_player_list.add_child(_inst_player_quickload)
		slot_ongoing = node_player_list.get_child_count()
		pass
	


func quicksave_list():
	var _file = FileAccess.open("user://player_list.dat", FileAccess.WRITE)
	if _file == null:
		return
	var _name_list = []
	for _child in node_player_list.get_children():
		if _child is not MarginContainer: 
			_name_list.erase(_child)
			continue
		if (_child.get_node_or_null(
			"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
			) != null ):
			_name_list.append(_child.get_node_or_null(
			"PlayerDecor/PlayerTemplateMargin/PlayerContainer/PlayerNameLabel"
			).text)
		
	var _json_data = JSON.stringify(_name_list)
	_file.store_string(_json_data)
