extends "res://Levels/BaseLevel.gd"

func get_camera(name):
	match name:
		"julia": 
			return {
				camera = $JuliaCamera,
				animation = $CameraAnimationPlayer
			}
		"romero":
			return {
				camera = $RomeroCamera,
				animation = $CameraAnimationPlayer
			}

func _level_key():
	return "level2"
