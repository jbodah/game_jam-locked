extends Node2D

var specs_by_node = {}
var level

func initialize(the_level):
	level = the_level
	Music.play(level.music())
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
	for i in specs.size():
		var spec = specs[i]
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
	if event is InputEventMouseButton && event.pressed:
		if specs_by_node.has(id):
			var receiver = specs_by_node.get(id).get("onclick")[0]
			var method = specs_by_node.get(id).get("onclick")[1]
			var args = specs_by_node.get(id).get("onclick")[2]
			receiver.callv(method, args)

func on_mouse_entered(id):
	if specs_by_node.has(id):
		$HUD.add(specs_by_node[id].name)

func on_mouse_exited(id):
	if specs_by_node.has(id):
		$HUD.remove(specs_by_node[id].name)

func format_id(path):
	return String(path).split("/")[-1]

func play_spec(spec):
	$HUD.render_spec(spec)
