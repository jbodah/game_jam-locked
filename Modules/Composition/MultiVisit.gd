extends "res://Modules/BaseModule.gd"

var spec = {}

func _initialize(the_spec):
	spec = the_spec
	if !spec.has("index"):
		spec["index"] = 0
	spawn_child(spec.subsections[spec["index"]])

func on_child_close(_child):
	if spec.subsections.size() > spec["index"] + 1:
		spec["index"] += 1
	close()
