extends Node2D

signal done

const LeftClick = preload("res://Util/LeftClick.gd")

var sticky_spec = {
	type = preload("res://Modules/StickyNote.tscn"),
	message = "password123"
}

var password = "password123"

var child

func _ready():
	Music.play("level1")
	$StickyNote.connect("input_event", self, "on_sticky_input_event")
	$StickyNote.connect("mouse_entered", self, "on_sticky_mouse_entered")
	$StickyNote.connect("mouse_exited", self, "on_sticky_mouse_exited")
	$LineEdit.connect("text_entered", self, "on_text_entered")
	$LineEdit.connect("text_changed", self, "on_text_changed")

func on_sticky_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func on_sticky_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func on_sticky_input_event(_camera, event, _click_pos):
	if LeftClick.is_left_click(event):
		child = sticky_spec.type.instance()
		child.connect("ready", self, "on_child_ready", [sticky_spec])
		add_child(child)

func on_child_ready(spec):
	child.connect("close", self, "on_child_close", [spec])
	child.initialize(spec)

func on_child_close(_spec):
	remove_child(child)
	child.queue_free()
	child = null

func on_text_changed(_text):
	$LineEdit.add_color_override("font_color", Color.black)

func on_text_entered(text):
	if text.to_lower() == password.to_lower():
		print("done title")
		emit_signal("done")
	else:
		$LineEdit.add_color_override("font_color", Color.red)
		yield(get_tree().create_timer(0.1), "timeout")
		$LineEdit.add_color_override("font_color", Color.black)
		yield(get_tree().create_timer(0.1), "timeout")
		$LineEdit.add_color_override("font_color", Color.red)
		yield(get_tree().create_timer(0.1), "timeout")
		$LineEdit.add_color_override("font_color", Color.black)
