extends "res://Modules/BaseModule.gd"

func _initialize(spec):
	if spec.flag_provider.get_flag(spec.flag):
		spawn_child(spec.subsections[0])
	else:
		spawn_child(spec.subsections[1])
