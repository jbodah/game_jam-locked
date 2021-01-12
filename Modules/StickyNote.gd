extends "res://Modules/BaseModule.gd"

class_name StickyNote

const SPEED = 1.5

func _initialize(spec):
	$Label.text = spec.message

func _ready():
	$AnimationPlayer.playback_speed = SPEED
	$AnimationPlayer.play("fly_up_in")
	$AnimationPlayer.connect("animation_finished", self, "on_animation_finished")

func _process(_delta):
	if just_clicked() || just_hit_enter():
		$AnimationPlayer.play("fly_up_out")

func on_animation_finished(name):
	if name == "fly_up_out":
		close()
