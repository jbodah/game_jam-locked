extends Node

const Data = preload("res://Util/Data.gd")

var config: ConfigFile
var search_index = {}

func _init():
	config = Data.load_config("pages")[1]
	for page_id in config.get_sections():
		for search_term in search_terms_for(page_id):
			index_search_term(search_term, page_id)

func get_page(page_id):
	var section_keys = config.get_section_keys(page_id)
	var rv = {"page_id": page_id}
	for i in range(section_keys.size()):
		var key = section_keys[i]
		rv[key] = config.get_value(page_id, key)
	return rv

func index_search_term(search_term, page_id):
	print("indexing search term; page_id=%s search_term=%s" % [page_id, search_term])
	var value = search_index.get(search_term, [])
	value.push_back(page_id)
	search_index[search_term] = value

func search(text):
	var results = {}
	for word in sanitize(text).split(" "):
		for result in search_index.get(word, []):
			var page = get_page(result)
			results[page.page_id] = page
	return results.values()

func search_terms_for(page_id):
	var set = {}
	var indexed_fields = ["desc_text", "link_text", "header_text"]
	for field in indexed_fields:
		var field_text = config.get_value(page_id, field)
		var keys = sanitize(field_text).split(" ")
		for key in keys:
			set[key] = true
	return set.keys()

func sanitize(string):
	var regexp = RegEx.new()
	regexp.compile("[^a-z0-9 ]")
	return regexp.sub(string.to_lower(), " ", true)
