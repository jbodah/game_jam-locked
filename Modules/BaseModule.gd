extends Node2D

signal close

var ignore_input = true
var timer = Timer.new()

func initialize(spec):
	if spec.has("sound_open"):
		SoundEffect.play(spec["sound_open"])
	_initialize(spec)

func _initialize(_spec):
	pass

func delay_input():
	timer.wait_time = 0.1
	timer.autostart = true
	add_child(timer)
	yield(timer, "timeout")
	ignore_input = false

func just_clicked():
	return !ignore_input && Input.is_action_just_pressed("click")

func just_hit_enter():
	return !ignore_input && Input.is_action_just_pressed("ui_accept")

func close():
	emit_signal("close")
