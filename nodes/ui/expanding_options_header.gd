extends HBoxContainer

func resize_buttons(width):
	for basewButtonChild in get_children():
		if basewButtonChild is BaseButton:
			print(basewButtonChild)
			basewButtonChild.custom_minimum_size.x = width
