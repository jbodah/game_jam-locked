extends Node2D

const Data = preload("res://Util/Data.gd")

const SimpleMessage = preload("res://Modules/SimpleMessage.tscn")
const PasswordMessage = preload("res://Modules/PasswordMessage.tscn")
const MultiPhaseMessage = preload("res://Modules/MultiPhaseMessage.tscn")

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
	match spec["type"]:
		"simple":
			spec["scene"] = SimpleMessage
		"password":
			spec["scene"] = PasswordMessage
		"multi_phase_message":
			spec["scene"] = MultiPhaseMessage
	return spec
