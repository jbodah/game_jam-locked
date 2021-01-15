extends "res://Modules/BaseModule.gd"

var camera
var animation

func _initialize(spec):
	var rv = spec.camera_provider.get_camera(spec.camera)
	camera = rv.camera
	animation = rv.animation
	camera.current = true
	animation.playback_speed = float(spec.speed)
	animation.play("ZoomIn")
	yield(animation, "animation_finished")
	spawn_child(spec.subsections[0])
	
func on_child_close(child):
	remove_child(child)
	animation.play_backwards("ZoomIn")
	yield(animation, "animation_finished")
	camera.current = false
	close()
