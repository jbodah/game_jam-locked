extends Node

signal correct_password_entered
signal next_level
signal play_animation
signal hint_shown

func emit_next_level():
	emit_signal("next_level")

func emit_correct_password_entered(spec):
	emit_signal("correct_password_entered", spec)
	
func emit_play_animation(name):
	emit_signal("play_animation", name)
	
func emit_hint_shown(was_last_hint):
	emit_signal("hint_shown", was_last_hint)
