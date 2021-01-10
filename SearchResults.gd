extends Node2D

var game

func _ready():
	$MagnifyingGlass.connect("input_event", self, "on_SearchResults_MagnifyingGlass_input_event")
	$SearchResultsContainer/SearchResult0/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [0])
	$SearchResultsContainer/SearchResult1/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [1])
	$SearchResultsContainer/SearchResult2/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [2])
	$SearchResultsContainer/SearchResult3/LinkLabel.connect("gui_input", self, "on_SearchResult_Link_input_event", [3])

func initialize(the_game):
	game = the_game

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") && visible:
		game.search_text = $Searchbar.text
		game.search()

func do_show():
	show()
	$Searchbar.caret_blink = true
	$Searchbar.text = game.search_text
	$Searchbar.grab_focus()
	$Searchbar.caret_position = game.search_text.length()

	$ResultCountLabel.text = "Found %s results." % game.search_results.size()
	for i in range(4):
		var node = get_node("SearchResultsContainer/SearchResult" + String(i))
		node.hide()

	for i in range(game.search_results.size()):
		var node = get_node("SearchResultsContainer/SearchResult" + String(i))
		node.show()
		node.get_node("UrlLabel").text = game.search_results[i].url_text
		node.get_node("LinkLabel").text = game.search_results[i].link_text
		node.get_node("DescLabel").text = game.search_results[i].desc_text

func on_SearchResults_MagnifyingGlass_input_event(event):
	if event is InputEventMouseButton:
		game.search_text = $Searchbar.text
		game.search()

func on_SearchResult_Link_input_event(event, idx):
	if event is InputEventMouseButton && event.pressed:
		game.show_page(game.search_results[idx])
