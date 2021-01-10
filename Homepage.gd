extends Node2D

var game

func _ready():
	$SearchButton.connect("pressed", self, "on_Homepage_SearchButton_pressed")

func initialize(the_game):
	game = the_game

func do_show():
	$Searchbar.grab_focus()
	$Searchbar.caret_blink = true
	show()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && visible:
		game.search_text = $Searchbar.text
		game.search()

func on_Homepage_SearchButton_pressed():
	game.search_text = $Searchbar.text
	game.search()
