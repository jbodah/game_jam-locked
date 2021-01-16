extends Node2D

const LeftClick = preload("res://Util/LeftClick.gd")

var google

func _ready():
	$MagnifyingGlass.connect("input_event", self, "on_SearchResults_MagnifyingGlass_input_event")
	$SearchResultsContainer/SearchResult0/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [0])
	$SearchResultsContainer/SearchResult1/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [1])
	$SearchResultsContainer/SearchResult2/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [2])
	$SearchResultsContainer/SearchResult3/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [3])

func initialize(the_google):
	google = the_google

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && visible:
		google.search_text = $Searchbar.text
		google.search()

func do_show():
	show()
	$Searchbar.caret_blink = true
	$Searchbar.text = google.search_text
	$Searchbar.grab_focus()
	$Searchbar.caret_position = google.search_text.length()

	$ResultCountLabel.text = "Found %s results." % google.search_results.size()
	for i in range(4):
		var node = get_node("SearchResultsContainer/SearchResult" + String(i))
		node.hide()

	for i in range(google.search_results.size()):
		var node = get_node("SearchResultsContainer/SearchResult" + String(i))
		node.show()
		node.get_node("UrlLabel").text = google.search_results[i].url_text
		node.get_node("LinkLabel").text = google.search_results[i].link_text
		node.get_node("DescLabel").text = google.search_results[i].desc_text

func on_SearchResults_MagnifyingGlass_input_event(_camera, event, _click_pos):
	if LeftClick.is_left_click(event):
		google.search_text = $Searchbar.text
		google.search()

func on_SearchResult_Link_input_event(event, idx):
	if LeftClick.is_left_click(event):
		google.show_page(google.search_results[idx])
