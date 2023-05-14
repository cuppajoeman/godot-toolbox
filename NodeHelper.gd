static func delete_children(parent: Node):
	for child in parent.get_children():
		parent.remove_child(child)
		child.queue_free()
