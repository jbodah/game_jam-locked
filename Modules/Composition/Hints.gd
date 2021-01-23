extends "res://Modules/BaseModule.gd"

var spec = {}

func _initialize(the_spec):
	spec = the_spec
	if !spec.has("index"):
		spec["index"] = 0
	spawn_child(spec.subsections[spec["index"]])

func on_child_close(_child):
	var was_last_hint = true
	if spec.subsections.size() > spec["index"] + 1:
		spec["index"] += 1
		was_last_hint = false
	spec.event_bus.emit_hint_shown(was_last_hint)
	close()
