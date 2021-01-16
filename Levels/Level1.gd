extends "res://Levels/BaseLevel.gd"

var angry_range = 5

func _ready():
	var init_x = $lvl1/Danny.position.x
	var animation = Animation.new()
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, "lvl1/Danny:position:x")
	var start = 0.0
	var step = 0.05
	animation.track_insert_key(track_index, start, init_x)
	start+=step
	animation.track_insert_key(track_index, start, init_x-angry_range)
	start+=step
	animation.track_insert_key(track_index, start, init_x)
	start+=step
	animation.track_insert_key(track_index, start, init_x+angry_range)
	start+=step
	animation.track_insert_key(track_index, start, init_x)
	start+=step
	animation.track_insert_key(track_index, start, init_x-angry_range)
	start+=step
	animation.track_insert_key(track_index, start, init_x)
	start+=step
	animation.track_insert_key(track_index, start, init_x+angry_range)
	start+=step
	animation.track_insert_key(track_index, start, init_x)
	$BossAnimationPlayer.add_animation("angry", animation)
	
func get_camera(name):
	match name:
		"boss": 
			return {
				camera = $BossCamera,
				animation = $BossCameraAnimationPlayer
			}
			
func on_play_animation(name):
	match name:
		"boss_angry": $BossAnimationPlayer.play("angry")

func _level_key():
	return "level1"
