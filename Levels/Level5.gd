extends "res://Levels/BaseLevel.gd"

var passwords_entered = 0

func get_camera(name):
	match name:
		"steve": 
			return {
				camera = $SteveCamera,
				animation = $CameraAnimationPlayer
			}

func _level_key():
	return "level5"
	
func on_play_animation(name):
	match name:
		"burn": $FireAnimationPlayer.play("Burn")
	
func on_correct_password_entered(spec):
	match spec.id:
		"steve_s_computer":
			flag_provider.set_flag("steve_computer_unlocked")
			var child_spec = find_child_spec("steve")
			play_spec(child_spec)
			play_spec(find_child_spec("_next_level"))
