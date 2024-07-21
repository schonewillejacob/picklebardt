extends Node
class_name RuleSet


enum modes {RoundRobin_BestEffort}
@export var _player_count = 4

func _init(player_count : int):
	_player_count = player_count
	print(str(player_count))
