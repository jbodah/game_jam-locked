extends "res://Modules/BaseModule.gd"

class_name MultiPhaseMessage

var spec = {}

func _ready():
	$SimpleMessage.connect("close", self, "on_message_close")

func _initialize(the_spec):
	spec = the_spec
	if !spec.has("index"):
		spec["index"] = 0
	var phase = spec.phases[spec["index"]]
	$SimpleMessage.initialize(phase)

func on_message_close():
	if spec.phases.size() > spec["index"] + 1:
		spec["index"] += 1
	close()
