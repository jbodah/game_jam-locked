extends "res://Levels/BaseLevel.gd"

func get_camera(name):
	match name:
		"julia": 
			return {
				camera = $JuliaCamera,
				animation = $JuliaCameraAnimationPlayer
			}

func _level_key():
	return "level2"
