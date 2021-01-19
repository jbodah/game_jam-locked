extends Control

const Path = preload("res://Util/Path.gd")

func _ready():
	if get_tree().current_scene == self:
		Music.play("level1")
		show()
	randomize()
	var children = get_children()
	var grid = GridContainer.new()
	add_child(grid)
	for child in children:
		var button = Button.new()
		button.text = Path.last(child.get_path())
		button.connect("pressed", self, "play", [button.text])
		grid.add_child(button)

func play(name):
	print("play sound: %s" % name)
	get_node(name).play()
