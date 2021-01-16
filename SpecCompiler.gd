const TYPE_LOOKUP = {
	simple = preload("res://Modules/Messages/SimpleMessage.tscn"),
	password = preload("res://Modules/Messages/PasswordMessage.tscn"),
	multi_visit = preload("res://Modules/Composition/MultiVisit.tscn"),
	sticky_note = preload("res://Modules/StickyNote.tscn"),
	search_engine = preload("res://Modules/SearchEngine/Google.tscn"),
	calendar = preload("res://Modules/Calendar.tscn"),
	sequence = preload("res://Modules/Composition/Sequence.tscn"),
	dialogue = preload("res://Modules/Dialogue.tscn"),
	choice = preload("res://Modules/Choice.tscn"),
	camera_zoom = preload("res://Modules/CameraZoom.tscn"),
	next_level = preload("res://Modules/NextLevel.tscn"),
	play_animation = preload("res://Modules/PlayAnimation.tscn"),
	branch = preload("res://Modules/Branch.tscn")
}

static func compile_spec(spec):
	spec["type"] = TYPE_LOOKUP[spec["type"]]
	if spec.has("subsections"):
		var subspecs = []
		for subsection in spec["subsections"]:
			subspecs.push_back(compile_spec(subsection))
		spec["subsections"] = subspecs
	return spec
