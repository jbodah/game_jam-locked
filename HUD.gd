extends CanvasLayer

const Stack = preload("res://Util/Stack.gd")

var stack = Stack.new()
var state = "explore"
var can_transition = true

onready var hover = $HoverLabel
onready var response_container = $ResponseContainer

func _ready():
	response_container.connect("close", self, "on_response_container_close")

func _process(_delta):
	if state == "response":
		response_container.show()
	else:
		response_container.hide()
		hover.rect_position.x = get_viewport().get_mouse_position().x + 20
		hover.rect_position.y = get_viewport().get_mouse_position().y + 20
		if stack.size() == 0:
			hover.hide()
		else:
			hover.show()
			hover.text = Stack.top(stack)

func add(name):
	Stack.push(stack, name)

func remove(name):
	Stack.evict(stack, name)

func render_spec(spec):
	state = "response"
	response_container.render_child(spec)

func on_response_container_close():
	state = "explore"
