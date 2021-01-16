extends "res://Modules/BaseModule.gd"

const LeftClick = preload("res://Util/LeftClick.gd")

var spec = {}
var available_choices = []

func _ready():
	for idx in range(4):
		var node = get_node("BaseMessage/Label%s" % idx)
		node.connect("gui_input", self, "on_choice_made", [idx])
		node.connect("mouse_entered", self, "on_choice_mouse_entered", [idx])
		node.connect("mouse_exited", self, "on_choice_mouse_exited", [idx])
		node.hide()
		node.text = ""

func _initialize(the_spec):
	spec = the_spec

	var idx = -1
	for choice in spec.choices:
		idx += 1
		if !is_available(choice):
			continue
		choice["subsection_idx"] = idx
		available_choices.push_back(choice)

	for idx2 in range(4):
		if available_choices.size() > idx2:
			var node = get_node("BaseMessage/Label%s" % idx2)
			node.text = "* " + available_choices[idx2].message
			node.show()

func is_available(choice):
	if !choice.has("if_flag") && !choice.has("not_if_flag"):
		return true
		
	var should_show = true
	if choice.has("if_flag"):
		should_show = spec.flag_provider.get_flag(choice.if_flag)
	var should_hide = false
	if choice.has("not_if_flag"):
		should_hide = spec.flag_provider.get_flag(choice.not_if_flag)
		
	return should_show && !should_hide

func on_choice_made(event, idx):
	if LeftClick.is_left_click(event):
		$BaseMessage.hide()
		var subsection_idx = available_choices[idx].subsection_idx
		spawn_child(spec.subsections[subsection_idx])

func on_choice_mouse_entered(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.green)

func on_choice_mouse_exited(idx):
	var node = get_node("BaseMessage/Label%s" % idx)
	node.add_color_override("font_color", Color.white)
