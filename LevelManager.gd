extends Node2D

const Title = preload("res://Title.tscn")
const Level1 = preload("res://Levels/Level1.tscn")
const Level2 = preload("res://Levels/Level2.tscn")
const Level5 = preload("res://Levels/Level5.tscn")

var child
var current = {
	builder = Title,
	next = {
		builder = Level1,
		next = {
			builder = Level5,
			next = {
				builder = Level2
			}
		}
	}
}

func _init():
	start_phase()

func start_phase():
	child = current.builder.instance()
	child.connect("done", self, "on_phase_done")
	add_child(child)

func on_phase_done():
	remove_child(child)
	if current.has("next"):
		current = current.next
		start_phase()
	else:
		get_tree().quit()
