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
		button.connect("pressed", self, button.text)
		grid.add_child(button)

func play(name):
	call(name)

func rummage():
	play_for($rummage, rand_range(0, 2), 2)

func modem():
	play_for($modem, 10.1, 2.1)

func cartoon_voice():
	play_for($cartoon_voice, 0, 0.7)
	
func mumble():
	$mumble.play()

func fanfare():
	$fanfare.play()

func success():
	$success.play()

func fail():
	$fail.play()

func typing():
	play_for($typing, 0, 1)

func romero_chuckle():
	$romero_chuckle.play()

func play_for(node, start, duration):
	node.play(start)
	yield(get_tree().create_timer(duration), "timeout")
	node.stop()
