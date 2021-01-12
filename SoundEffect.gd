extends Control

const Path = preload("res://Util/Path.gd")

func _ready():
	if get_tree().current_scene == self:
		show()
	randomize()
	var children = get_children()
	for child in children:
		var button = Button.new()
		button.text = Path.last(child.get_path())
		button.connect("pressed", self, button.text)
		add_child(button)

func play(name):
	call(name)

func rummage():
	var start = rand_range(0, 2)
	var node = get_node("rummage")
	node.play(start)
	yield(get_tree().create_timer(2), "timeout")
	node.stop()
