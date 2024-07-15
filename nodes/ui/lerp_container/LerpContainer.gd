extends Control
class_name LerpContainer

@export var position_in_place : Vector2
@export var position_away : Vector2
var position_target : Vector2
var lerping : int = 0 # [-1,1]

func _ready():
	position_in_place = position
	position_target = position_away
	modulate.a = 0

func _process(delta):
	# Can we move?
	position = lerp(position, position_target, .90)
	#if position != position_target:
		#modulate.a = clamp( modulate.a + (0.006 * lerping), 0, 1)

func toggle_position_target() -> void:
	match position_target:
		position_in_place:
			position_target = position_away
			lerping = -1
		position_away:
			position_target = position_in_place
			lerping = 1

