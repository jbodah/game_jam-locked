extends Node2D

var google

func initialize(the_google, header_text, body_text):
	google = the_google
	$Header.text = header_text
	$Body.text = body_text

func do_show():
	show()
