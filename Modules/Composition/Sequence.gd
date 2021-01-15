extends "res://Modules/BaseModule.gd"

var spec = {}
var curr = 0

func _initialize(the_spec):
	spec = the_spec
	curr = 0
	render_next_subsection()

func on_child_close(child):
	if spec.subsections.size() > curr + 1:
		remove_child(child)
		curr += 1
		render_next_subsection()
	else:
		close()
		
func render_next_subsection():
	var child_spec = spec.subsections[curr]
	spawn_child(child_spec)
