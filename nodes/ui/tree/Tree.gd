extends Node2D
class_name SwayingTree

var stack_height : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for st_child in get_children():
		if st_child is SwayingTree:
			st_child.try_swaying()

func try_swaying():
	stack_height += 1
	scale += Vector2(0.1,0.1)
	
	$top.visible = true
	$stump.visible = false
	$AnimationPlayer.play("sway")
