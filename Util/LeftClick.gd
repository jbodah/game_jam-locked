static func is_left_click(event):
	return event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT
