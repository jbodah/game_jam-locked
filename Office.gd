extends Node2D

onready var office = $OfficeScreen
onready var google = $Google

func _ready():
	office.initialize(self)
	remove_child(google)

func open_google():
	add_child(google)
	remove_child(office)

func close_google():
	remove_child(google)
	add_child(office)
