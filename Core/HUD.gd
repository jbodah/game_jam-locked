extends CanvasLayer

const Stack = preload("res://Util/Stack.gd")

var stack = Stack.new()
var state = "explore"
var can_transition = true

onready var hover = $HoverLabel

func _ready():
	$LevelSelectButton.connect("pressed", self, "on_level_select_button_pressed")

func _process(_delta):
	if state == "explore":
		hover.rect_position.x = get_viewport().get_mouse_position().x - 30
		hover.rect_position.y = get_viewport().get_mouse_position().y + 20
		if stack.size() == 0:
			hover.hide()
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		else:
			hover.show()
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			hover.text = Stack.top(stack)
	else:
		hover.hide()

func add_hover(name):
	Stack.push(stack, name)

func remove_hover(name):
	Stack.evict(stack, name)

func on_level_select_button_pressed():
	get_tree().change_scene("res://BootLoader.tscn")
