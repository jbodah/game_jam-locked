extends Node2D

signal closed

class_name Google

var page_manager = PageManager
var search_text: String
var search_results: Array
var history = []

func _ready():
	$Homepage.initialize(self)
	$SearchResults.initialize(self)
	$BrowserControls/BackButton.connect("pressed", self, "on_back")
	$BrowserControls/QuitButton.connect("pressed", self, "on_quit")
	show_homepage()

func search():
	search_results = do_search(search_text)
	show_search_results()

func do_search(text):
	return page_manager.search(text)

func show_homepage():
	$Homepage.do_show()
	$BrowserControls/BackButton.hide()
	$SearchResults.hide()
	$Page.hide()

func show_search_results():
	history = ["show_homepage"]
	$BrowserControls/BackButton.show()
	$Homepage.hide()
	$Page.hide()
	$SearchResults.do_show()

func show_page(page):
	if $Homepage.visible:
		history = ["show_homepage"]
	else:
		history = ["show_homepage", "show_search_results"]
	$BrowserControls/BackButton.show()
	$Homepage.hide()
	$SearchResults.hide()
	$Page.do_show()
	$Page.initialize(self, page.header_text, page.body_text)

func on_back():
	call(history.pop_back())

func on_quit():
	emit_signal("closed")
