extends "res://Modules/BaseModule.gd"

class_name PasswordMessage

var state = "enter_password"
var spec = {"pass_message": "you win", "actual_password": "meatball", "fail_message": "try again later"}

onready var line_edit = $EnterPassword/LineEdit
onready var result = $Result
onready var outside = $Outside

func _ready():
	SoundEffect.play("typing")
	outside.connect("gui_input", self, "on_outside_gui_input")
	line_edit.grab_focus()
	line_edit.connect("text_entered", self, "check_password", [])

func _initialize(the_spec):
	spec = the_spec

func _process(_delta):
	match state:
		"enter_password":
			$EnterPassword.show()
			$Result.hide()
		"password_pass":
			$EnterPassword.hide()
			$Result.show()
			if just_clicked() || just_hit_enter():
				spec.event_bus.emit_correct_password_entered(spec)
				close()
		"password_fail":
			$EnterPassword.hide()
			$Result.show()
			if just_clicked() || just_hit_enter():
				close()

func on_outside_gui_input(_event):
	if just_clicked():
		close()

func check_password(text):
	delay_input()
	if is_password_match(text, spec.passwords):
		$Background.color = Color("198b13")
		SoundEffect.play("success")
		state = "password_pass"
		result.text = spec.pass_message
	else:
		SoundEffect.play("fail")
		$AnimationPlayer.play("flash_red")
		state = "password_fail"
		result.text = spec.fail_message

func sanitize(text: String):
	var regex = RegEx.new()
	regex.compile("[^A-Za-z0-9]")
	return regex.sub(text, "")

func is_password_match(text, passwords):
	text = sanitize(text).to_lower()
	for password in passwords:
		if password.to_lower() == text:
			return true
	return false
