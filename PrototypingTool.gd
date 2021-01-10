extends Node2D

const Data = preload("res://Util/Data.gd")

var next

onready var left = $HBoxContainer/VBoxContainer
onready var right = $HBoxContainer/VBoxContainer2

func _ready():
	var load_res = Data.load_config("level1")
	if load_res[0]:
		$CanvasLayer/UserOverride.text = "OVERRIDE"
	var config = load_res[1]
	next = left
	var sections = config.get_sections()
	for i in sections.size():
		var spec = {"id": sections[i]}
		var keys = config.get_section_keys(sections[i])
		for j in keys.size():
			spec[keys[j]] = config.get_value(sections[i], keys[j])
		add_button(spec)
	$CanvasLayer/Screen.hide()
	$CanvasLayer/Screen/BackButton.connect("pressed", self, "hide_overlay_screen")

func hide_overlay_screen():
	$CanvasLayer/Screen.hide()
	$HBoxContainer.show()

func play_message(spec):
	$CanvasLayer/Screen.show()
	$HBoxContainer.hide()
	$CanvasLayer/Screen/ResponseContainer.render_child(spec)

func add_button(spec):
	var button = Button.new()
	button.text = spec.name
	button.connect("pressed", self, "play_message", [spec])
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	next.add_child(button)
	if next == left:
		next = right
	else:
		next = left
