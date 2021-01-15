extends Node2D

const LevelConfig = preload("res://LevelConfig.gd")

var _specs

func _ready():
	$Core.initialize(self)
	for spec in specs():
		if spec.id == "_intro":
			$Core.play_spec(spec)
			break

func specs():
	if !_specs:
		_specs = LevelConfig.new(_level_key()).compile()
	return _specs

func object_root_node():
	return $YSort

func music():
	return _level_key()

func _level_key():
	return String(get_path()).get_basename().get_file().to_lower()
