extends Node

class_name LimitedList

var base_list = []
var max_elements

func _init(max_elements: int):
	self.max_elements = max_elements
	
func append(element):
	if self.base_list.size() == self.max_elements:
		base_list.remove_at(0)
	base_list.append(element)
