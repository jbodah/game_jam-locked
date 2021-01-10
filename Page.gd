extends Node2D

var game

func initialize(the_game, header_text, body_text):
	game = the_game
	$Header.text = header_text
	$Body.text = body_text

func do_show():
	show()
