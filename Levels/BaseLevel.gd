extends Node2D

const LevelConfig = preload("res://LevelConfig.gd")

func _ready():
	$Core.initialize(self)

func specs():
	return LevelConfig.new(_level_key()).compile()

func object_root_node():
	return $YSort

func music():
	return _level_key()

func _level_key():
	return String(get_path()).get_basename().get_file()
