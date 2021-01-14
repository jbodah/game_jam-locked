const SimpleMessage = preload("res://Modules/Messages/SimpleMessage.tscn")
const PasswordMessage = preload("res://Modules/Messages/PasswordMessage.tscn")
const MultiPhaseMessage = preload("res://Modules/Messages/MultiPhaseMessage.tscn")
const StickyNote = preload("res://Modules/StickyNote.tscn")
const Google = preload("res://Modules/SearchEngine/Google.tscn")
const Calendar = preload("res://Modules/Calendar.tscn")

static func spec_to_module(spec):
	match spec["type"]:
		"simple":
			return SimpleMessage.instance()
		"password":
			return PasswordMessage.instance()
		"multi_phase_message":
			return MultiPhaseMessage.instance()
		"sticky_note":
			return StickyNote.instance()
		"search_engine":
			return Google.instance()
		"calendar":
			return Calendar.instance()
		_:
			print("SpecToModule.spec_to_module: unrecognized type ", spec["type"])
