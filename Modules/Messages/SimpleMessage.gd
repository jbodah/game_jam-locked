extends "res://Modules/BaseModule.gd"

class_name SimpleMessage

func _initialize(spec):
	$BaseMessage/Label.text = spec.message

func _process(_delta):
	if just_clicked():
		close()
