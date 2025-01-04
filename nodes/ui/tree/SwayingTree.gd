extends Node2D
class_name SwayingTree

var stack_height        : int = 0
const STACK_DELTA       : Vector2 = Vector2(0.075,0.075)
var sway_timer = Timer.new()
var grow_timer = Timer.new()
const GROWTH_ELAPSED : float = 0.016 # target: 60 fps
const GROWTH_START : float = 2.0 # target: 60 fps
const RAND_OFFSET_SCALE : float = 5.0
@export var TARGET_SCALE : Vector2 = Vector2(1,1)



# Virtuals ####################################################
func _ready():
	print()
	
	# Create and comfigure timer.
	if get_children() == null:
		add_child(sway_timer)
		sway_timer.one_shot = true
		sway_timer.start(1.0)
		sway_timer.timeout.connect(start_sway)
	
	
	for _st_child in get_children():
		if _st_child is SwayingTree: 
			_st_child.try_swaying()
			
			_st_child.add_child(_st_child.grow_timer)
			_st_child.grow_timer.start(GROWTH_START + randf()*0.15)
			_st_child.grow_timer.timeout.connect(_st_child.lerp_grow)
			_st_child.scale.y = 0.001
			



# Helpers #####################################################
func start_sway() -> void:
## Stops growth timers
	for _st_child in get_children():
		if _st_child is SwayingTree: 
			_st_child.grow_timer.stop()

func lerp_grow() -> void:
	scale.y = lerp(scale.y,TARGET_SCALE.y,0.05)
	
	
	grow_timer.start(GROWTH_ELAPSED)

func try_swaying() -> void:
	## Changes sprite, adjust based scale
	
	stack_height += 1
	
	$top.visible = true
	$stump.visible = false
	
	$AnimationPlayer.play("sway")
	# Pseudorandom but consistantly positive
	# Creates offset effect
	$AnimationPlayer.seek(randf() * RAND_OFFSET_SCALE)
