extends Node2D

var specs_by_node = {}

func initialize(specs):
	index_specs(specs)
	var queue = get_children()
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
		if spec.node != null:
			assert(get_node(spec.node) != null)
			if !specs_by_node.has(spec.node):
				specs_by_node[spec.node] = spec
			if !specs_by_node[spec.node].onclick != null:
				specs_by_node[spec.node].onclick = [self, "play_spec", [spec]]
		else:
			print("Missing 'node' prop for ", spec.id)

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
	play_rummage_sound_effect()
	$HUD.render_spec(spec)

func play_rummage_sound_effect():
	var start = rand_range(0, 2)
	$Rummage.play(start)
	yield(get_tree().create_timer(2), "timeout")
	$Rummage.stop()
