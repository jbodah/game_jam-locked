extends "res://Modules/BaseModule.gd"

class_name MultiPhaseMessage

func _initialize(spec):
	if !spec.has("current"):
		spec["current"] = 0
	$BaseMessage/Label.text = spec.messages[spec["current"]]
	if spec.messages.size() > spec["current"]:
		spec["current"] += 1

func _process(_delta):
	if just_clicked():
		close()
