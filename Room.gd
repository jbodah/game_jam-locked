extends Node2D

# @deprecated

onready var room = $RoomSprite
onready var label = $Label

var onclick := {}
var game

func initialize(the_game):
	game = the_game

func _ready():
	label.text = ""
	$Room/Computer.connect("input_event", room, "on_input_event", ["computer"])
	$Room/Calendar.connect("input_event", room, "on_input_event", ["calendar"])
	$Room/Noteboard.connect("input_event", room, "on_input_event", ["noteboard"])
	$Room/Picture.connect("input_event", room, "on_input_event", ["picture"])

func on_input_event(_camera, event, _click_pos, id):
	if event is InputEventMouseButton:
		var method = onclick.get(id)[0]
		var args = onclick.get(id)[1]
		callv(method, args)

func print_text(text):
	label.text = text

func delegate_game(method):
	game.call(method)
