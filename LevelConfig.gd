class_name LevelConfig

const Data = preload("res://Util/Data.gd")

var config

func _init(level_name):
	config = Data.load_config(level_name)[1]

func compile():
	var specs = []
	var sections = config.get_sections()
	for i in sections.size():
		var spec = _build_spec(sections[i])
		specs.push_back(spec)
	return specs

func _build_spec(section):
	var spec = {"id": section, "onclick": null, "node": null}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		spec[keys[j]] = config.get_value(section, keys[j])
	return spec
