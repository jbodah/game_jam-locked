extends Node2D

const LeftClick = preload("res://Util/LeftClick.gd")

var specs_by_node = {}
var lock = Mutex.new()
var spec_queue = []
var level
var child

onready var event_bus = $EventBus

func initialize(the_level):
	level = the_level
	index_specs(level.specs())
	var queue = [level.object_root_node()]
	while queue.size() > 0:
		var el = queue.pop_front()
		if el is Area2D:
			el.connect("input_event", self, "on_input_event", [format_id(el.get_path())])
			el.connect("mouse_entered", self, "on_mouse_entered", [format_id(el.get_path())])
			el.connect("mouse_exited", self, "on_mouse_exited", [format_id(el.get_path())])
		else:
			var el_children = el.get_children()
			for i in el_children.size():
				queue.push_back(el_children[i])

func index_specs(specs):
	for spec in specs:
		if spec.id[0] == "_":
			continue
		if !spec.has("node"):
			print("Section '%s' is missing 'node' property" % spec.id)
			continue
		if level.object_root_node().get_node(spec.node) == null:
			print("Couldn't find node: '%s'" % spec.node)
			continue
		if !specs_by_node.has(spec.node):
			specs_by_node[spec.node] = spec
		if !specs_by_node[spec.node].has("onclick"):
			specs_by_node[spec.node].onclick = [self, "play_spec", [spec]]

func on_input_event(_camera, event, _click_pos, id):
	if LeftClick.is_left_click(event):
		if specs_by_node.has(id):
			var receiver = specs_by_node.get(id).get("onclick")[0]
			var method = specs_by_node.get(id).get("onclick")[1]
			var args = specs_by_node.get(id).get("onclick")[2]
			receiver.callv(method, args)

func on_mouse_entered(id):
	if specs_by_node.has(id):
		$HUD.add_hover(specs_by_node[id].name)

func on_mouse_exited(id):
	if specs_by_node.has(id):
		$HUD.remove_hover(specs_by_node[id].name)

func format_id(path):
	return String(path).split("/")[-1]

func play_spec(spec):
	$HUD.state = "response"
	lock.lock()
	if child || spec_queue.size() > 0:
		spec_queue.push_back(spec)
		lock.unlock()
	else:
		child = spec.type.instance()
		lock.unlock()
		_do_play_child(spec)
		
func _do_play_child(spec):
	child.connect("ready", self, "on_child_ready", [spec])
	$HUD/ChildContainer.add_child(child)

func on_child_ready(spec):
	child.connect("close", self, "on_child_close", [spec])
	child.initialize(spec)

func on_child_close(_spec):
	var next_spec
	
	$HUD/ChildContainer.remove_child(child)
	child.queue_free()
	lock.lock()
	child = null
	if spec_queue.size() > 0:
		next_spec = spec_queue.pop_front()
		child = next_spec.type.instance()
	lock.unlock()
	if child:
		_do_play_child(next_spec)
	else:
		$HUD.state = "explore"
