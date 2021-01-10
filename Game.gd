extends Node2D

var next

onready var left = $PlaceholderControls/HBoxContainer/VBoxContainer
onready var right = $PlaceholderControls/HBoxContainer/VBoxContainer2

func _ready():
	# $Office.office.onclick = {
	#   "computer": [
	#     "delegate_game",
	#     ["open_google"]
	#   ],
	#   "calendar": [
	#     "print_text",
	#     ["I have a dentist appointment next week. Can't forget"]
	#   ],
	#   "picture": [
	#     "print_text",
	#     ["Our trip to the Bahamas was amazing"]
	#   ],
	#   "noteboard": [
	#     "print_text",
	#     ["password123... What could it mean??"]
	#   ]
	# }
	# $Office/OfficeScreen/Computer.connect("input_event", $Office.office, "on_input_event", ["computer"])
	# $Office/OfficeScreen/Calendar.connect("input_event", $Office.office, "on_input_event", ["calendar"])
	# $Office/OfficeScreen/Noteboard.connect("input_event", $Office.office, "on_input_event", ["noteboard"])
	# $Office/OfficeScreen/Picture.connect("input_event", $Office.office, "on_input_event", ["picture"])
	var config = ConfigFile.new()
	var file = File.new()
	if file.file_exists("user://level1.cfg"):
		config.load("user://level1.cfg")
		$PlaceholderControls/CanvasLayer/UserOverride.text = "OVERRIDE"
	else:
		config.load("res://data/level1.cfg")
	next = left
	var sections = config.get_sections()
	for i in sections.size():
		var spec = {"id": sections[i]}
		var keys = config.get_section_keys(sections[i])
		for j in keys.size():
			spec[keys[j]] = config.get_value(sections[i], keys[j])
		add_button(spec)
	$PlaceholderControls/CanvasLayer/Screen/BackButton.connect("pressed", self, "hide_overlay_screen")

func hide_overlay_screen():
	$PlaceholderControls/CanvasLayer/Screen.hide()
	$PlaceholderControls/HBoxContainer.show()

func play_message(spec):
	$PlaceholderControls/CanvasLayer/Screen.show()
	$PlaceholderControls/HBoxContainer.hide()
	$PlaceholderControls/CanvasLayer/Screen/ResponseContainer.render_child(spec)

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
