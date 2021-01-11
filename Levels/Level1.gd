extends Node2D

const Data = preload("res://Util/Data.gd")

func _ready():
	var config = Data.load_config("level1")[1]
	var specs = build_specs_from_config(config)
	$BaseLevel.initialize(specs)

func build_specs_from_config(config):
	var specs = []
	var sections = config.get_sections()
	for i in sections.size():
		var spec = build_spec(config, sections[i])
		specs.push_back(spec)
	return specs

func build_spec(config, section):
	var spec = {"id": section, "onclick": null, "node": null}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		spec[keys[j]] = config.get_value(section, keys[j])
	return spec
