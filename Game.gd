extends Node2D

func _ready():
	add_load_level_button(1)
	add_load_level_button(2)

func load_level(level_name):
	print("Loading %s" % level_name)
	get_tree().change_scene("res://Levels/" + level_name + ".tscn")

func add_load_level_button(n):
	var button = Button.new()
	button.text = "Load Level %s" % n
	button.connect("pressed", self, "load_level", ["Level%s" % n])
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
