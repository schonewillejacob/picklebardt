extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	resize_buttons(null)

func resize_buttons(width):
	for child in get_children():
		print(child)
		#if child is BaseButton: child.width = width
