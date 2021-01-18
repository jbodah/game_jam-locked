extends Control

const Path = preload("res://Util/Path.gd")

func _ready():
	if get_tree().current_scene == self:
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
	if has_method(name):
		call(name)
	else:
		get_node(name).play()

func rummage():
	play_for($rummage, rand_range(0, 2), 2)

func modem():
	play_for($modem, 10.1, 2.1)

func cartoon_voice():
	play_for($cartoon_voice, 0, 0.7)
	
func typing():
	play_for($typing, 0, 1)
	
func steve_hey():
	play_for($steve_hey, 0, 2)
	
func coffee():
	play_for($coffee, 1, 1.5)

func play_for(node, start, duration):
	node.play(start)
	yield(get_tree().create_timer(duration), "timeout")
	node.stop()
