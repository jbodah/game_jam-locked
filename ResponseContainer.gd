extends Control

var last
func render_child(spec):
	match spec["type"]:
		"multi_phase_message":
			replace_child(render_multi_phase_message(spec))
		"password":
			replace_child(render_password(spec))
		"simple":
			replace_child(render_simple(spec))

func replace_child(new_child):
	if last:
		remove_child(last)
		last.queue_free()
	add_child(new_child)
	last = new_child

func render_multi_phase_message(spec):
	if spec.has("_last"):
		var candidate = "message" + String(spec["_last"] + 1)
		if spec.has(candidate):
			spec["_last"] += 1
			return label(spec[candidate])
		else:
			return label(spec["message" + String(spec["_last"])])
	else:
		spec["_last"] = 1
		return label(spec["message1"])

func render_password(spec):
	var control = Control.new()
	var label = Label.new()
	label.text = "Please enter the password"
	label.rect_position = Vector2(0, 0)
	var line_edit = LineEdit.new()
	line_edit.placeholder_text = "type password"
	line_edit.rect_position = Vector2(0, 30)
	line_edit.rect_size.x = 500
	line_edit.connect("text_entered", self, "check_password", [spec])
	control.add_child(label)
	control.add_child(line_edit)
	return control

func check_password(text, spec):
	if text == spec.actual_password:
		replace_child(label(spec.pass_message))
	else:
		replace_child(label(spec.fail_message))

func render_simple(spec):
	return label(spec.message)

func label(text):
	var label = Label.new()
	label.text = text
	return label
