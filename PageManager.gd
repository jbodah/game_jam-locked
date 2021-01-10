extends Node

var config: ConfigFile
var search_index = {}

func _init():
	config = ConfigFile.new()
	config.load("res://data/pages.cfg")
	var sections = config.get_sections()
	for i in range(sections.size()):
		var page_id = sections[i]
		var search_terms = search_terms_for(page_id)
		for j in range(search_terms.size()):
			index_search_term(search_terms[j], page_id)

func get_page(page_id):
	var section_keys = config.get_section_keys(page_id)
	var rv = {"page_id": page_id}
	for i in range(section_keys.size()):
		var key = section_keys[i]
		rv[key] = config.get_value(page_id, key)
	return rv

func index_search_term(search_term, page_id):
	var value = search_index.get(search_term, [])
	value.push_back(page_id)
	search_index[search_term] = value

func search(text):
	var results = search_index.get(text, [])
	var rv = []
	for i in range(results.size()):
		rv.push_back(get_page(results[i]))
	return rv

func search_terms_for(page_id):
	var set = {}
	var desc_text = config.get_value(page_id, "desc_text")
	var keys = sanitize(desc_text).split(" ")
	for i in range(keys.size()):
		set[keys[i]] = true
	return set.keys()

func sanitize(string):
	var regexp = RegEx.new()
	regexp.compile("[^A-Za-z0-9 ]")
	return regexp.sub(string, " ", true)
