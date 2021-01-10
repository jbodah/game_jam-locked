extends Node2D

const PrototypingTool = preload("res://PrototypingTool.tscn")
const Office = preload("res://Office.tscn")

func _ready():
	$BootLoader/TestUI.connect("pressed", self, "on_Chooser_TestUI_pressed")
	$BootLoader/ContentPrototyping.connect("pressed", self, "on_Chooser_ContentPrototyping_pressed")

func on_Chooser_TestUI_pressed():
	remove_child($BootLoader)
	add_child(Office.instance())

func on_Chooser_ContentPrototyping_pressed():
	remove_child($BootLoader)
	add_child(PrototypingTool.instance())

