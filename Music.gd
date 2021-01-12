extends Control

const Path = preload("res://Util/Path.gd")

var curr
var enabled = true

func _ready():
	if self == get_tree().current_scene:
		show()
	var children = get_children()
	var grid = GridContainer.new()
	add_child(grid)
	for child in children:
		var button = Button.new()
		button.text = Path.last(child.get_path())
		button.connect("pressed", self, button.text)
		grid.add_child(button)

func play(name):
	if !enabled:
		return
	if curr:
		stop(curr)
	else:
		curr = name
		call(name)

func stop(name):
	get_node(name).stop()

func level1():
	$level1.play()
