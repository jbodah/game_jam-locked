extends Node2D

const Data = preload("res://Util/Data.gd")

func _ready():
	$BaseLevel.initialize(Data.load_config("level1")[1])
