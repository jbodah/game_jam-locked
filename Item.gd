class Item:
	var id
	var node
	var name
	var onclick

	static func build(id, node, name, onclick):
		var inst = Item.new()
		inst.id = id
		inst.node = node
		inst.name = name
		inst.onclick = onclick
		return inst
