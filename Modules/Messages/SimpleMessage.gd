extends "res://Modules/BaseModule.gd"

class_name SimpleMessage

var queue = []

onready var label = $BaseMessage/Label
onready var caret = $BaseMessage/Caret

func _initialize(spec):
	if spec.has("message"):
		queue = [spec.message]
	else:
		queue = spec.messages.duplicate()
	label.text = queue.pop_front()

func _process(_delta):
	if just_clicked():
		if queue.size() == 0:
			close()
		else:
			label.text = queue.pop_front()
	if queue.size() > 0:
		caret.show()
	else:
		caret.hide()

