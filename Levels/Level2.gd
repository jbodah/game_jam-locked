extends "res://Levels/BaseLevel.gd"

var passwords_entered = 0

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
	
func on_correct_password_entered(spec):
	match spec.id:
		"romero_s_computer":
			flag_provider.set_flag("romero_computer_unlocked")
			var child_spec = find_child_spec("romero")
			play_spec(child_spec)
			passwords_entered += 1
			if passwords_entered == 2:
				play_spec(find_child_spec("_next_level"))
		"julia_s_computer":
			flag_provider.set_flag("julia_computer_unlocked")
			var child_spec = find_child_spec("julia")
			play_spec(child_spec)
			passwords_entered += 1
			if passwords_entered == 2:
				play_spec(find_child_spec("_next_level"))
