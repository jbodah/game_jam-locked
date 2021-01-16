extends Node2D

const Title = preload("res://Title.tscn")
const Level1 = preload("res://Levels/Level1.tscn")

var child

func _init():
	child = Title.instance()
	child.connect("done", self, "on_child_done")
	add_child(child)

func on_child_done():
	remove_child(child)
	child = Level1.instance()
	add_child(child)
