extends Node2D

signal done

const LevelConfig = preload("res://LevelConfig.gd")
const NextLevel = preload("res://Modules/NextLevel.tscn")

const HINT_COOLDOWN = 60

var _specs
var flag_provider = FlagStore

func _ready():
	$Core.initialize(self)
	$Core.event_bus.connect("correct_password_entered", self, "on_correct_password_entered")
	$Core.event_bus.connect("next_level", self, "on_next_level")
	$Core.event_bus.connect("play_animation", self, "on_play_animation")
	$Core.event_bus.connect("hint_shown", self, "on_hint_shown")
	$Core.hide_hint_for(HINT_COOLDOWN)
	if !Music.is_playing:
		Music.play(_level_key())
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

func on_hint_shown(was_last_hint):
	if !was_last_hint:
		$Core.hide_hint_for(HINT_COOLDOWN)
