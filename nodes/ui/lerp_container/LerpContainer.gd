extends Control
class_name LerpContainer

## makes a containers not visible if modulate.a is under MODULATE_VISIBLE_THRESHOLD

# lerping
@export var positionInPlace : Vector2
@export var positionAway    : Vector2
var positionTarget          : Vector2
var lerpDirection           : int = -1 # [-1,1]
# modulation
const FADE_OUT_RATE              : float = 5.0
const FADE_IN_RATE               : float = 2.0
const MODULATE_VISIBLE_THRESHOLD : float = 0.1

#signal FadeOut
#signal FadeIn



# Virtuals ####################################################
func _ready():
	# positioning logic
	# Holds UI in position.
	positionInPlace = get_position()
	positionTarget = positionAway
	
	# makes menus invisible right away, just in case
	modulate.a = -1

func _process(delta):
	
	if lerpDirection > 0:
		#set_position(lerp(get_position(), positionTarget, .99))
		modulate.a = clamp( modulate.a + (FADE_IN_RATE * lerpDirection)*delta, 0.0, 1)
	elif lerpDirection < 0:
		modulate.a = clamp( modulate.a + (FADE_OUT_RATE * lerpDirection)*delta, 0, 0.66)
	
	if modulate.a < MODULATE_VISIBLE_THRESHOLD:
		visible = false
	else:
		visible = true



# Signals #####################################################
# Helpers #####################################################
