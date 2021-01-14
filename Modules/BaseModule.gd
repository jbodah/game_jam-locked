extends Node2D

signal close

var ignore_input = false

func initialize(spec):
	if spec.has("sound_open"):
		SoundEffect.play(spec["sound_open"])
	delay_input()
	_initialize(spec)

func _initialize(_spec):
	pass

func delay_input():
	ignore_input = true
	yield(get_tree().create_timer(0.1), "timeout")
	ignore_input = false

func just_clicked():
	return !ignore_input && Input.is_action_just_pressed("click")

func just_hit_enter():
	return !ignore_input && Input.is_action_just_pressed("ui_accept")

func close():
	if get_tree().current_scene == self:
		print("DEBUG: close()")
	emit_signal("close")
