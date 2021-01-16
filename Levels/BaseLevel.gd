extends Node2D

signal done

const LevelConfig = preload("res://LevelConfig.gd")
const FlagStore = preload("res://FlagStore.gd")
const NextLevel = preload("res://Modules/NextLevel.tscn")

var _specs
var flag_provider = FlagStore.new()

func _ready():
	$Core.initialize(self)
	$Core.event_bus.connect("correct_password_entered", self, "on_correct_password_entered")
	$Core.event_bus.connect("next_level", self, "on_next_level")
	$Core.event_bus.connect("play_animation", self, "on_play_animation")
	yield(get_tree().create_timer(0.2), "timeout")
	maybe_play_intro()

func play_spec(spec):
	$Core.play_spec(spec)

func find_child_spec(id):
	for spec in specs():
		if spec.id == id:
			return spec

func maybe_play_intro():
	var spec = find_child_spec("_intro")
	if spec:
		play_spec(spec)

func maybe_play_outro():
	var spec = find_child_spec("_outro")
	if spec:
		play_spec(spec)

func specs():
	if !_specs:
		_specs = LevelConfig.new(_level_key(), self, $Core.event_bus, flag_provider).compile()
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
	maybe_play_outro()

func on_next_level():
	print("emit_signal('done')")
	emit_signal("done")

func on_play_animation(_name):
	pass
