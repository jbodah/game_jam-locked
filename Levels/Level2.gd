extends "res://Levels/BaseLevel.gd"

func get_camera(name):
	match name:
		"julia": 
			return {
				camera = $JuliaCamera,
				animation = $JuliaCameraAnimationPlayer
			}
