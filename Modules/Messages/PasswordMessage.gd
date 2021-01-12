extends "res://Modules/BaseModule.gd"

class_name PasswordMessage

signal correct_password_entered

var state = "enter_password"

onready var line_edit = $EnterPassword/LineEdit
onready var result = $Result

func _process(_delta):
	match state:
		"enter_password":
			$EnterPassword.show()
			$Result.hide()
		"password_pass":
			$EnterPassword.hide()
			$Result.show()
			if just_clicked() || just_hit_enter():
				emit_signal("correct_password_entered")
				close()
		"password_fail":
			$EnterPassword.hide()
			$Result.show()
			if just_clicked() || just_hit_enter():
				close()

func _initialize(spec):
	line_edit.connect("text_entered", self, "check_password", [spec])

func check_password(text, spec):
	delay_input()
	if text == spec.actual_password:
		state = "password_pass"
		result.text = spec.pass_message
	else:
		state = "password_fail"
		result.text = spec.fail_message

