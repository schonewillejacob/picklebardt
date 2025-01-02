extends Node2D
class_name SwayingTree

var stack_height        : int = 0
const STACK_DELTA       : Vector2 = Vector2(0.075,0.075)
const RAND_OFFSET_SCALE : float = 5.0

func _ready():
	for _st_child in get_children():
		if _st_child is SwayingTree: _st_child.try_swaying()

func try_swaying():
	stack_height += 1
	scale =  scale - (STACK_DELTA * (stack_height*2))
	
	$top.visible = true
	$stump.visible = false
	
	# Pseudorandom but consistantly positive
	# Creates offset effect
	$AnimationPlayer.seek(randf() * RAND_OFFSET_SCALE)
