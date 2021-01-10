# @return [Tuple<Bool, ConfigFile>] whether or not a user override was loaded
static func load_config(filename) -> Array:
	var config = ConfigFile.new()
	var file = File.new()
	if file.file_exists("user://" + filename + ".cfg"):
		config.load("user://" + filename + ".cfg")
		return [true, config]
	else:
		config.load("res://data/" + filename + ".cfg")
		return [false, config]
