extends Node2D

const PrototypingTool = preload("res://Debug/PrototypingTool.tscn")
const TestUI = preload("res://Debug/TestUI.tscn")
const Level1 = preload("res://Levels/Level1.tscn")

func _ready():
	add_test_ui()
	add_content_prototyping()
	add_level1()

func do_load(scene):
	remove_child($BootLoader)
	add_child(scene.instance())

func add_test_ui():
	$BootLoader/TestUI.connect("pressed", self, "do_load", [TestUI])

func add_content_prototyping():
	$BootLoader/ContentPrototyping.connect("pressed", self, "on_Chooser_ContentPrototyping_pressed")

func on_Chooser_ContentPrototyping_pressed():
	remove_child($BootLoader)
	var pt = PrototypingTool.instance()
	add_child(pt)
	pt.initialize("level1")

func add_level1():
	$BootLoader/Level1.connect("pressed", self, "do_load", [Level1])
