extends Node2D

const Item = preload("res://Item.gd")

onready var google = $Google

func _ready():
	var specs = [
		Item.build("computer", "Computer", "Bob's Computer", [self, "open_google", []]),
		Item.build("calendar", "Calendar", "Last year's calendar", [self, "print_text", ["I have a dentist appointment next week. Can't forget"]]),
		Item.build("picture", "Picture", "Family photo", [self, "print_text", ["Our trip to the Bahamas was amazing"]]),
		Item.build("noteboard", "Noteboard", "Old sticky notes", [self, "print_text", ["password123... What could it mean??"]])
	]
	$BaseLevel.initialize(specs)
	google.connect("closed", self, "on_google_closed")
	remove_child(google)

func open_google():
	add_child(google)

func on_google_closed():
	remove_child(google)

func print_text(text):
	$BaseLevel/Label.text = text
