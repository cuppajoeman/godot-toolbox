extends Node

class_name OneTimeEvent

"""
OneTimeEvent

description:
	this class takes a callable function, it has a run method, which only calls
	the callable function the first time it's invoked
	
use case:
	you have a flag inside of a loop which only gets set a certain number of 
	iterations into the loop, and then becomes true. When that flag is true,
	we want to do something once, but since it's in a loop it gets run every 
	iteration. This class solves this issue
"""

var count = 0
var function_to_call

func _init(function_to_call):
	self.function_to_call = function_to_call
	
# TODO make it work for functions which take parameters as well.
func run():
	if count == 0:
		function_to_call.call()
	

