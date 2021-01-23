extends Node2D

const shake_range = 1

func _ready():
	$Timer.connect("timeout", $AnimationPlayer, "play", ["Shake"])
