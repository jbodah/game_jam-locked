static func new():
	return []

static func top(stack):
	return last(stack)

static func last(stack):
	if stack.size() > 0:
		return stack[-1]
	else:
		return null

static func push(stack, el):
	stack.push_back(el)

static func pop(stack):
	return stack.pop_back()

static func evict(stack, el):
	stack.remove(el)
