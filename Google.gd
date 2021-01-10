extends Node2D

class_name Google

var page_manager = PageManager
var search_text: String
var search_results: Array
var game

func _ready():
	$Homepage.initialize(self)
	$SearchResults.initialize(self)
	$BrowserControls/BackButton.connect("pressed", self, "on_back")
	$BrowserControls/QuitButton.connect("pressed", self, "on_quit")
	show_homepage()

func initialize(the_game):
	game = the_game

func search():
	search_results = page_manager.search(search_text)
	show_search_results()

func show_homepage():
	$Homepage.do_show()
	$SearchResults.hide()
	$Page.hide()

func show_search_results():
	$Homepage.hide()
	$Page.hide()
	$SearchResults.do_show()

func show_page(page):
	$Homepage.hide()
	$SearchResults.hide()
	$Page.do_show()
	$Page.initialize(self, page.header_text, page.body_text)

func on_back():
	if $SearchResults.visible:
		show_homepage()
	elif $Page.visible:
		show_search_results()

func on_quit():
	if game:
		game.close_google()
	else:
		get_tree().quit()
