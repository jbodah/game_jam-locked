extends "res://Modules/BaseModule.gd"

func _initialize(spec):
	spec.event_bus.emit_signal("next_level")
