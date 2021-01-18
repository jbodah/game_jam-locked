extends Node2D

func _ready():
	add_load_full_game_button()
	add_load_title_button()
	add_load_level_button(1)
	add_load_level_button(2)
	add_load_level_button(5)
	add_load_sound_effect_button()
	add_load_music_button()

func add_load_full_game_button():
	var button = Button.new()
	button.text = "Load Full Game"
	button.connect("pressed", self, "load_full_game")
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
	
func load_full_game():
	get_tree().change_scene("res://LevelManager.tscn")
	
func add_load_sound_effect_button():
	var button = Button.new()
	button.text = "Load Sound Effect Debug"
	button.connect("pressed", self, "load_sound_effects")
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
	
func load_sound_effects():
	get_tree().change_scene("res://SoundEffect.tscn")

func add_load_music_button():
	var button = Button.new()
	button.text = "Load Music Debug"
	button.connect("pressed", self, "load_music")
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
	
func load_music():
	get_tree().change_scene("res://Music.tscn")

func add_load_title_button():
	var button = Button.new()
	button.text = "Load Title"
	button.connect("pressed", self, "load_title")
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
	
func load_title():
	get_tree().change_scene("res://Title.tscn")

func add_load_level_button(n):
	var button = Button.new()
	button.text = "Load Level %s" % n
	button.connect("pressed", self, "load_level", ["Level%s" % n])
	button.size_flags_horizontal = button.SIZE_EXPAND_FILL
	button.size_flags_vertical = button.SIZE_EXPAND_FILL
	$BootLoader.add_child(button)
	
func load_level(level_name):
	get_tree().change_scene("res://Levels/" + level_name + ".tscn")
