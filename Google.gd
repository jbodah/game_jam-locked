extends Node2D

class_name Google

var search_text
var current

func _ready():
	current = "home"
	$Homepage.show()
	$SearchResults.hide()
	$Homepage/Searchbar.grab_focus()
	$Homepage/Searchbar.caret_blink = true
	$Homepage/SearchButton.connect("pressed", self, "on_Homepage_SearchButton_pressed")

	$SearchResults/Searchbar.caret_blink = true
	$SearchResults/MagnifyingGlass.connect("input_event", self, "on_SearchResults_MagnifyingGlass_input_event")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if current == "home":
			search_text = $Homepage/Searchbar.text
		else:
			search_text = $SearchResults/Searchbar.text
		search()

func search():
	$Homepage.hide()
	$SearchResults.show()
	$SearchResults/Searchbar.text = search_text
	$SearchResults/Searchbar.grab_focus()
	$SearchResults/Searchbar.caret_blink = true
	$SearchResults/Searchbar.caret_position = search_text.length()
	show_search_results()

func show_search_results():
	$SearchResults/ResultCountLabel.text = "Found 4 results."
	for i in range(4):
		var node = get_node("SearchResults/SearchResultsContainer/SearchResult" + String(i))
		node.get_node("UrlLabel").text = "en.wikipedia.org › wiki › BoardGameGeek"
		node.get_node("LinkLabel").text = "BoardGameGeek - Wikipedia"
		node.get_node("DescLabel").text = "BoardGameGeek (BGG) is an online forum for board gaming hobbyists and a game database that holds reviews, images and videos for over 101,000 different ..."

func on_Homepage_SearchButton_pressed():
	search_text = $Homepage/Searchbar.text
	search()

func on_SearchResults_MagnifyingGlass_input_event(event):
	if event is InputEventMouseButton:
		search_text = $SearchResults/Searchbar.text
		search()
