extends Node2D

func _ready():
	$BootLoader/TestUI.connect("pressed", get_tree(), "change_scene", ["res://Debug/TestUI.tscn"])
	$BootLoader/Level1.connect("pressed", get_tree(), "change_scene", ["res://Levels/Level1.tscn"])
