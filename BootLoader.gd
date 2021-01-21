extends Node2D

func _ready():
	add_load_full_game_button()
	add_load_title_button()
	add_load_level_button(1)
	add_load_level_button(2)
	add_load_level_button(5)
	add_load_level_button(3)
	add_load_sound_effect_button()
	add_load_music_button()

func add_load_full_game_button():
	var button = make_button("Load Full Game")
	button.connect("pressed", self, "load_full_game")
	$BootLoader.add_child(button)

func load_full_game():
	get_tree().change_scene("res://LevelManager.tscn")

func add_load_sound_effect_button():
	var button = make_button("Load Sound Effect Debug")
	button.connect("pressed", self, "load_sound_effects")
	$BootLoader.add_child(button)

func load_sound_effects():
	get_tree().change_scene("res://SoundEffect.tscn")

func add_load_music_button():
	var button = make_button("Load Music Debug")
	button.connect("pressed", self, "load_music")
	$BootLoader.add_child(button)

func load_music():
	get_tree().change_scene("res://Music.tscn")

func add_load_title_button():
	var button = make_button("Load Title")
	button.connect("pressed", self, "load_title")
	$BootLoader.add_child(button)

func load_title():
	get_tree().change_scene("res://Title.tscn")

func add_load_level_button(n):
	var button = make_button("Load Level %s" % n)
	button.connect("pressed", self, "load_level", ["Level%s" % n])
	$BootLoader.add_child(button)

func load_level(level_name):
	get_tree().change_scene("res://Levels/" + level_name + ".tscn")

func make_button(text):
	var button = Button.new()
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.text = text
	return button
