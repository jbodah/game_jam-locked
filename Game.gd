extends Node2D

func _ready():
	$BootLoader/Level1.connect("pressed", get_tree(), "change_scene", ["res://Levels/Level1.tscn"])
