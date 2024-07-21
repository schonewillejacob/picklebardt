extends Control
class_name PickleballGame

@onready matchContainer = $MatchContainer
var _matchCount : int = 1

func _init(matchCount : int) -> void:
	_matchCount = matchCount

func _ready() -> void:
	custom_minimum_size = Vector2(get_viewport_rect().size.x / 2,256)
	for i in _matchCount:
		var child_match = preload("res://nodes/ui/menu_bracket/game/Match.tscn").instantiate()
		print(child_match)
		matchContainer.add_child(child_match)
