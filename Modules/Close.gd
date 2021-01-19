extends "res://Modules/BaseModule.gd"

func _initialize(_spec):
	yield(get_tree().create_timer(0.3), "timeout")
	close()
