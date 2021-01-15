class_name LevelConfig

const Data = preload("res://Util/Data.gd")
const SpecCompiler = preload("res://SpecCompiler.gd")

var config

func _init(level_name):
	config = Data.load_config(level_name)[1]

func compile():
	var specs = []
	for section in config.get_sections():
		var compiled = SpecCompiler.compile_spec(section_to_dict(section))
		specs.push_back(compiled)
	return specs

func section_to_dict(section):
	var dict = {"id": section}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		dict[keys[j]] = config.get_value(section, keys[j])
	return dict
