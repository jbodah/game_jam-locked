extends Node2D

onready var room = $RoomSprite
onready var label = $Label

var onclick := {
	"computer": [
		"open_google",
		[]
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

var game

func initialize(the_game):
	game = the_game

func _ready():
	label.text = ""
	$Computer.connect("input_event", self, "on_input_event", ["computer"])
	$Calendar.connect("input_event", self, "on_input_event", ["calendar"])
	$Noteboard.connect("input_event", self, "on_input_event", ["noteboard"])
	$Picture.connect("input_event", self, "on_input_event", ["picture"])

func on_input_event(_camera, event, _click_pos, id):
	if event is InputEventMouseButton:
		var method = onclick.get(id)[0]
		var args = onclick.get(id)[1]
		callv(method, args)

func print_text(text):
	label.text = text

func open_google():
	game.open_google()
