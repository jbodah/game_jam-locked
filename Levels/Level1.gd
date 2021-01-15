extends "res://Levels/BaseLevel.gd"

const SpecCompiler = preload("res://SpecCompiler.gd")

func _ready():
	for spec in specs():
		if spec.id == "_intro":
			$Core.play_spec(spec)
			break
