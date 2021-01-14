# @return [Tuple<Bool, ConfigFile>] whether or not a user override was loaded
static func load_config(filename) -> Array:
	var config = ConfigFile.new()
	var file = File.new()
	var user_path = "user://" + filename + ".cfg"
	if file.file_exists(user_path):
		var err = config.load(user_path)
		assert(err == 0, "Invalid user file: %s" % user_path)
		return [true, config]
	else:
		var path = "res://data/" + filename + ".cfg"
		var err = config.load(path)
		assert(err == 0, "Invalid resource file: %s" % path)
		return [false, config]
