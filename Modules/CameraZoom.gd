extends "res://Modules/BaseModule.gd"

var camera
var animation
var spec

func _initialize(the_spec):
	spec = the_spec
	var rv = spec.camera_provider.get_camera(spec.camera)
	camera = rv.camera
	animation = rv.animation
	animation.playback_speed = float(spec.speed)
	animation.connect("animation_started", self, "on_animation_started")
	animation.play("ZoomIn")
	yield(animation, "animation_finished")
	spawn_child(spec.subsections[0])
	
func on_animation_started(_animation):
	camera.current = true
	
func on_child_close(child):
	remove_child(child)
	animation.play_backwards("ZoomIn")
	yield(animation, "animation_finished")
	camera.current = false
	close()
