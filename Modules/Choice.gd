extends "res://Modules/BaseModule.gd"

var spec = {}

func _ready():
	$BaseMessage/Label0.connect("gui_input", self, "on_choice_made", [0])
	$BaseMessage/Label1.connect("gui_input", self, "on_choice_made", [1])
	$BaseMessage/Label2.connect("gui_input", self, "on_choice_made", [2])
	$BaseMessage/Label3.connect("gui_input", self, "on_choice_made", [3])
	$BaseMessage/Label0.connect("mouse_entered", self, "on_choice_mouse_entered", [0])
	$BaseMessage/Label1.connect("mouse_entered", self, "on_choice_mouse_entered", [1])
	$BaseMessage/Label2.connect("mouse_entered", self, "on_choice_mouse_entered", [2])
	$BaseMessage/Label3.connect("mouse_entered", self, "on_choice_mouse_entered", [3])
	$BaseMessage/Label0.connect("mouse_exited", self, "on_choice_mouse_exited", [0])
	$BaseMessage/Label1.connect("mouse_exited", self, "on_choice_mouse_exited", [1])
	$BaseMessage/Label2.connect("mouse_exited", self, "on_choice_mouse_exited", [2])
	$BaseMessage/Label3.connect("mouse_exited", self, "on_choice_mouse_exited", [3])
	
func _initialize(the_spec):
	spec = the_spec
	for idx in range(4):
		if spec.choices.size() > idx:
			var node = get_node("BaseMessage/Label%s" % idx)
			node.text = "* " + spec.choices[idx]
	
func on_choice_made(event, idx):
	if event is InputEventMouseButton && event.pressed:
		$BaseMessage.hide()
		var child_spec = spec.subsections[idx]
		var child = child_spec.type.instance()
		child.connect("ready", self, "on_child_ready", [child, child_spec])
		add_child(child)
	
func on_child_ready(child, child_spec):
	child.connect("close", self, "on_child_close", [child])
	child.initialize(child_spec)	

func on_child_close(_child):
	close()
	
func on_choice_mouse_entered(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.green)
	
func on_choice_mouse_exited(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.white)
