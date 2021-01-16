extends Node2D

signal done

const LevelConfig = preload("res://LevelConfig.gd")

var _specs

func _ready():
	$Core.initialize(self)
	$Core.event_bus.connect("correct_password_entered", self, "on_correct_password_entered")
	$Core.event_bus.connect("next_level", self, "on_next_level")
	$Core.event_bus.connect("play_animation", self, "on_play_animation")
	yield(get_tree().create_timer(0.2), "timeout")
	maybe_play_intro()

func maybe_play_intro():
	for spec in specs():
		if spec.id == "_intro":
			$Core.play_spec(spec)
			break

func maybe_play_outro():
	for spec in specs():
		if spec.id == "_outro":
			$Core.play_spec(spec)
			break

func specs():
	if !_specs:
		_specs = LevelConfig.new(_level_key(), self, $Core.event_bus).compile()
	return _specs

func get_camera(_name):
	pass

func object_root_node():
	return $level

func music():
	return _level_key()

func _level_key():
	pass

func on_correct_password_entered(_spec):
	yield(get_tree().create_timer(0.2), "timeout")
	maybe_play_outro()

func on_next_level():
	print("on_next_level()")
	emit_signal("done")

func on_play_animation(_name):
	pass
