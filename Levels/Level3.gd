extends "res://Levels/BaseLevel.gd"

var passwords_entered = 0

func get_camera(name):
	match name:
		"vincent": 
			return {
				camera = $VincentCamera,
				animation = $CameraAnimationPlayer
			}
		"michele": 
			return {
				camera = $MicheleCamera,
				animation = $CameraAnimationPlayer
			}

func _level_key():
	return "level3"
	
func on_correct_password_entered(spec):
	match spec.id:
		"vincent_s_computer":
			flag_provider.set_flag("unlocked_vincents_computer")
			var child_spec = find_child_spec("vincent")
			play_spec(child_spec)
			passwords_entered += 1
			if passwords_entered == 2:
				play_spec(find_child_spec("_next_level"))
		"michele_s_computer":
			flag_provider.set_flag("unlocked_micheles_computer")
			var child_spec = find_child_spec("michele")
			play_spec(child_spec)
			passwords_entered += 1
			if passwords_entered == 2:
				play_spec(find_child_spec("_next_level"))
