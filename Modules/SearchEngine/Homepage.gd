extends Node2D

var google

func _ready():
	$SearchButton.connect("pressed", self, "on_SearchButton_pressed")
	$FeelingLuckyButton.connect("pressed", self, "on_FeelingLuckyButton_pressed")

func initialize(the_google):
	google = the_google

func do_show():
	$Searchbar.grab_focus()
	$Searchbar.caret_blink = true
	show()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && visible:
		google.search_text = $Searchbar.text
		google.search()

func on_SearchButton_pressed():
	google.search_text = $Searchbar.text
	google.search()

func on_FeelingLuckyButton_pressed():
	var results = google.do_search($Searchbar.text)
	if results.size() > 0:
		google.show_page(results[0])
