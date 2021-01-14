class_name LevelConfig

const Data = preload("res://Util/Data.gd")
const TYPE_LOOKUP = {
	simple = preload("res://Modules/Messages/SimpleMessage.tscn"),
	password = preload("res://Modules/Messages/PasswordMessage.tscn"),
	multi_visit = preload("res://Modules/Composition/MultiVisit.tscn"),
	sticky_note = preload("res://Modules/StickyNote.tscn"),
	search_engine = preload("res://Modules/SearchEngine/Google.tscn"),
	calendar = preload("res://Modules/Calendar.tscn")
}

var config

func _init(level_name):
	config = Data.load_config(level_name)[1]

func compile():
	var specs = []
	for section in config.get_sections():
		var compiled = compile_section(section_to_dict(section))
		specs.push_back(compiled)
	return specs

func compile_section(spec):
	spec["type"] = TYPE_LOOKUP[spec["type"]]
	if spec.has("subsections"):
		var subspecs = []
		for subsection in spec["subsections"]:
			subspecs.push_back(compile_section(subsection))
		spec["subsections"] = subspecs
	return spec

func section_to_dict(section):
	var dict = {"id": section}
	var keys = config.get_section_keys(section)
	for j in keys.size():
		dict[keys[j]] = config.get_value(section, keys[j])
	return dict
