var flags = {}

func get_flag(name):
	return flags.has(name)
	
func set_flag(name):
	print("set_flag('%s')" % name)
	flags[name] = true
