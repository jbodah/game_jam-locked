extends Node2D

const Title = preload("res://Title.tscn")
const Credits = preload("res://Credits.tscn")
const Level1 = preload("res://Levels/Level1.tscn")
const Level2 = preload("res://Levels/Level2.tscn")
const Level3 = preload("res://Levels/Level3.tscn")
const Level5 = preload("res://Levels/Level5.tscn")

var current
var child
var queue = [
	Title,
	Level1,
	Level5,
	Level2,
	Level3,
	Credits
]

func _init():
	current = queue.pop_front()
	start_phase()

func start_phase():
	var prev = child
	child = current.instance()
	child.connect("done", self, "on_phase_done")
	if prev:
		child.connect("ready", self, "remove_child", [prev])
	add_child(child)

func on_phase_done():
	if queue.size() > 0:
		current = queue.pop_front()
		start_phase()
	else:
		get_tree().quit()
