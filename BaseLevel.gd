extends Node2D

var specs_by_node = {}
var config: ConfigFile

func initialize(the_config):
	config = the_config
	build_specs_from_config()
	var children = get_children()
	for i in children.size():
		var sub_children = children[i].get_children()
		for j in sub_children.size():
			if sub_children[j] is Area2D:
				sub_children[j].connect("input_event", self, "on_input_event", [format_id(children[i].get_path())])
				sub_children[j].connect("mouse_entered", self, "on_mouse_entered", [format_id(children[i].get_path())])
				sub_children[j].connect("mouse_exited", self, "on_mouse_exited", [format_id(children[i].get_path())])

func build_specs_from_config():
	var sections = config.get_sections()
	for i in sections.size():
		var spec = build_spec(sections[i])
		if spec.has("node"):
			assert(get_node(spec.node) != null)
			if !specs_by_node.has(spec.node):
				specs_by_node[spec.node] = spec
			specs_by_node[spec.node]["onclick"] = ["play_spec", [spec]]
		else:
			print("Missing 'node' prop for ", spec.id)

func build_spec(section):
	var spec = {"id": section}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		spec[keys[j]] = config.get_value(section, keys[j])
	return spec

func on_input_event(_camera, event, _click_pos, id):
	if event is InputEventMouseButton && event.pressed:
		if specs_by_node.has(id):
			var method = specs_by_node.get(id).get("onclick")[0]
			var args = specs_by_node.get(id).get("onclick")[1]
			callv(method, args)

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
