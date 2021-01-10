extends Node2D

onready var room = $RoomSprite
onready var label = $Label

var onclick := {}
var game

func initialize(the_game):
	game = the_game

func _ready():
	label.text = ""

func on_input_event(_camera, event, _click_pos, id):
	if event is InputEventMouseButton:
		var method = onclick.get(id)[0]
		var args = onclick.get(id)[1]
		callv(method, args)

func print_text(text):
	label.text = text

func delegate_game(method):
	game.call(method)
