extends Node2D

onready var room = $RoomSprite
onready var label = $Label

var onclick := {
	"computer": "If only I remembered my password...",
	"calendar": "I have a dentist appointment next week. Can't forget",
	"picture": "Our trip to the Bahamas was amazing",
	"noteboard": "password123... What could it mean??"
}

func _ready():
	label.text = ""
	$Computer.connect("input_event", self, "on_input_event", ["computer"])
	$Calendar.connect("input_event", self, "on_input_event", ["calendar"])
	$Noteboard.connect("input_event", self, "on_input_event", ["noteboard"])
	$Picture.connect("input_event", self, "on_input_event", ["picture"])

func on_input_event(_camera, event, _click_pos, id):
	if event is InputEventMouseButton:
		label.text = onclick.get(id)
