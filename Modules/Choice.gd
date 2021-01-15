extends "res://Modules/BaseModule.gd"

var spec = {}

func _ready():
	for idx in range(4):
		var node = get_node("BaseMessage/Label%s" % idx)
		node.connect("gui_input", self, "on_choice_made", [idx])
		node.connect("mouse_entered", self, "on_choice_mouse_entered", [idx])
		node.connect("mouse_exited", self, "on_choice_mouse_exited", [idx])
		node.text = ""
	
func _initialize(the_spec):
	spec = the_spec
	for idx in range(4):
		if spec.choices.size() > idx:
			var node = get_node("BaseMessage/Label%s" % idx)
			node.text = "* " + spec.choices[idx]
	
func on_choice_made(event, idx):
	if event is InputEventMouseButton && event.pressed:
		$BaseMessage.hide()
		spawn_child(spec.subsections[idx])
	
func on_choice_mouse_entered(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.green)
	
func on_choice_mouse_exited(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.white)
