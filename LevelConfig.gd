class_name LevelConfig

const Data = preload("res://Util/Data.gd")
const SpecCompiler = preload("res://SpecCompiler.gd")

var config
var camera_provider
var event_bus

func _init(level_name, the_camera_provider, the_event_bus):
	config = Data.load_config(level_name)[1]
	camera_provider = the_camera_provider
	event_bus = the_event_bus

func compile():
	var specs = []
	for section in config.get_sections():
		var spec = section_to_dict(section)
		var with_camera = add_camera_provider(spec)
		var compiled = SpecCompiler.compile_spec(with_camera)
		specs.push_back(compiled)
	return specs

func section_to_dict(section):
	var dict = {"id": section}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		dict[keys[j]] = config.get_value(section, keys[j])
	return dict

func add_camera_provider(spec):
	spec["camera_provider"] = camera_provider
	spec["event_bus"] = event_bus
	if spec.has("subsections"):
		var subspecs = []
		for subsection in spec["subsections"]:
			subspecs.push_back(add_camera_provider(subsection))
		spec["subsections"] = subspecs
	return spec
