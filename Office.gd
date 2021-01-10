extends Node2D

onready var room = $Room
onready var google = $Google

func _ready():
	seed_config()
	room.initialize(self)
	google.initialize(self)
	remove_child(google)

func seed_config():
	room.onclick = {
		"computer": [
			"delegate_game",
			["open_google"]
		],
		"calendar": [
			"print_text",
			["I have a dentist appointment next week. Can't forget"]
		],
		"picture": [
			"print_text",
			["Our trip to the Bahamas was amazing"]
		],
		"noteboard": [
			"print_text",
			["password123... What could it mean??"]
		]
	}
	$Room/Computer.connect("input_event", room, "on_input_event", ["computer"])
	$Room/Calendar.connect("input_event", room, "on_input_event", ["calendar"])
	$Room/Noteboard.connect("input_event", room, "on_input_event", ["noteboard"])
	$Room/Picture.connect("input_event", room, "on_input_event", ["picture"])

func open_google():
	add_child(google)
	remove_child(room)

func close_google():
	remove_child(google)
	add_child(room)
