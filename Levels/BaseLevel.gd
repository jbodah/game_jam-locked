extends Node2D

const LevelConfig = preload("res://LevelConfig.gd")

var _specs

func _ready():
	$Core.initialize(self)
	maybe_play_intro()

func maybe_play_intro():
	for spec in specs():
		if spec.id == "_intro":
			$Core.play_spec(spec)
			break
			
func specs():
	if !_specs:
		_specs = LevelConfig.new(_level_key(), self).compile()
	return _specs
	
func get_camera(_name):
	pass

func object_root_node():
	return $YSort

func music():
	return _level_key()

func _level_key():
	return String(get_path()).get_basename().get_file().to_lower()
