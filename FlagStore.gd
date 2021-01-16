var flags = {}

func get_flag(name):
	var rv = flags.has(name)
	print("get_flag('%s') => %s" % [name, rv])
	return rv
	
func set_flag(name):
	print("set_flag('%s')" % name)
	flags[name] = true
