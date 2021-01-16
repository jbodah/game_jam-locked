extends "res://Levels/BaseLevel.gd"

func get_camera(name):
	match name:
		"boss": 
			return {
				camera = $BossCamera,
				animation = $BossCameraAnimationPlayer
			}
