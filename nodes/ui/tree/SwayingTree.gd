extends Node2D
class_name SwayingTree

var stack_height : int = 0
const STACK_DELTA : Vector2 = Vector2(0.075,0.075)
const RAND_OFFSET_SCALE : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	for st_child in get_children():
		if st_child is SwayingTree:
			st_child.try_swaying()

func try_swaying():
	stack_height += 1
	scale =  scale - (STACK_DELTA * (stack_height*2))
	
	$top.visible = true
	$stump.visible = false
	
	# Pseudorandom but consistantly positive
	# Creates offset effect
	$AnimationPlayer.seek(randf() * RAND_OFFSET_SCALE)
