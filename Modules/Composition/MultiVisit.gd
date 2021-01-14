extends "res://Modules/BaseModule.gd"

var spec = {}

func _initialize(the_spec):
	spec = the_spec
	if !spec.has("index"):
		spec["index"] = 0
	var child_spec = spec.subsections[spec["index"]]
	var child = child_spec.type.instance()
	child.connect("ready", self, "on_child_ready", [child, child_spec])
	add_child(child)
	
func on_child_ready(child, child_spec):
	child.connect("close", self, "on_child_close", [child])
	child.initialize(child_spec)	

func on_child_close(_child):
	if spec.subsections.size() > spec["index"] + 1:
		spec["index"] += 1
	close()
