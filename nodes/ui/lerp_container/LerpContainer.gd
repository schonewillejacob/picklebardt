extends Control
class_name LerpContainer

@export var position_in_place : Vector2
@export var position_away : Vector2
var position_target : Vector2
var lerp_direction : int = -1 # [-1,1]

const FADE_OUT_RATE : float = 0.99
const FADE_IN_RATE : float = 0.8
const MODULATE_VISIBLE_THRESHOLD : float = 0.1

signal FadeOut
signal FadeIn

func _ready():
	# positioning logic
	# Holds UI imn position.
	position_in_place = get_position()
	position_target = position_away
	modulate.a = -1
	

func _process(delta):
	if lerp_direction > 0:
		#set_position(lerp(get_position(), position_target, .99))
		modulate.a = clamp( modulate.a + (FADE_IN_RATE * lerp_direction * delta), 0.0, 1)
	elif lerp_direction < 0:
		modulate.a = clamp( modulate.a + (FADE_OUT_RATE * lerp_direction * delta), 0, 0.66)
	
	if modulate.a < MODULATE_VISIBLE_THRESHOLD:
		visible = false
	else:
		visible = true
