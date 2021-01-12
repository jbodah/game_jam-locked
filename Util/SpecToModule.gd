const SimpleMessage = preload("res://Modules/Messages/SimpleMessage.tscn")
const PasswordMessage = preload("res://Modules/Messages/PasswordMessage.tscn")
const MultiPhaseMessage = preload("res://Modules/Messages/MultiPhaseMessage.tscn")
const StickyNote = preload("res://Modules/StickyNote.tscn")

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
		_:
			print("SpecToModule.spec_to_module: unrecognized type ", spec["type"])
