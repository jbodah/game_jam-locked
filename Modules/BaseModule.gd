extends Node2D

signal close

var ignore_input = false

func initialize(spec):
	if spec.has("sound_open"):
		SoundEffect.play(spec["sound_open"])
	if spec.has("set_flag"):
		spec.flag_provider.set_flag(spec.set_flag)
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
	
func spawn_child(child_spec):
		var child = child_spec.type.instance()
		child.connect("ready", self, "on_child_ready", [child, child_spec])
		add_child(child)
	
func on_child_ready(child, child_spec):
	child.connect("close", self, "on_child_close", [child])
	child.initialize(child_spec)	

func on_child_close(_child):
	close()
