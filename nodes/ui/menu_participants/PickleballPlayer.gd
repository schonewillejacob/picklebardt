extends Node
class_name PickleballPlayer

@export var _playerName : String

func _init(playerName : String = "player") -> void:
	_playerName = playerName

func _to_string() -> String:
	return _playerName
