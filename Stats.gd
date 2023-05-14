extends Node


var information_to_received_times = {
	"movement" : [],
	"mouse" : [],
	"process": []
}

var state_id_to_received_time_list = LimitedList.new(60 * 2)
var state_id_to_sent_time_list = LimitedList.new(60 * 2)

var movement_information_received_times = []

var num_samples = 100

# TODO turn this method into a LimitedList class
func add_information_received_time(information_type):
	var received_time = Time.get_ticks_msec()
	var information_received_times = information_to_received_times[information_type]
	if information_received_times.size() == num_samples:
		information_received_times.remove_at(0)
	information_received_times.append(received_time)

	
func get_delta_times(information_type):
	var delta_times = []
	var information_received_times = information_to_received_times[information_type]
	for i in range(0, len(information_received_times) - 2):
		var delta_time = information_received_times[i + 1] - information_received_times[i]
		delta_times.append(delta_time)
	return delta_times
	
func total_time(delta_times) -> float:
	var sum = 0
	for delta_time in delta_times:
		sum += delta_time
	return sum

func average_information_delta(information_type) -> float:
	var delta_times = get_delta_times(information_type)
	return total_time(delta_times) / len(delta_times)
	
func information_frequency_hz(information_type) -> float:
	return 1000 / average_information_delta(information_type)
	
func get_stats() -> String:
	var average_string = "FPS: %d \n" % Engine.get_frames_per_second()
	for information_type in information_to_received_times.keys():
		average_string += "%s: %f Hz\n" % [
			information_type, 
			information_frequency_hz(information_type)
		]
	average_string += "average round trip time: %d ms" % int(average_round_trip_time_ms())
	return average_string
	
	
# NETWORK STUFF
func convert_list_of_unique_key_value_to_object(key_value_list):
	var object = {}
	for key_value in key_value_list:
		var keys = key_value.keys()
		var key = keys[0]
		var value = key_value[key]
		object[key] = value
	return object


func average_round_trip_time_ms() -> float:
	
	var total_round_trip_time_ms = 0
	var total_round_trips_completed = 0
	
	var state_id_to_sent_time = convert_list_of_unique_key_value_to_object(state_id_to_sent_time_list.base_list)
	var state_id_to_received_time = convert_list_of_unique_key_value_to_object(state_id_to_received_time_list.base_list)
	
	for state_id in state_id_to_received_time.keys():
		var received_time = state_id_to_received_time[state_id]
		if state_id in state_id_to_sent_time.keys():
			var sent_time = state_id_to_sent_time[state_id]
			var round_trip_time_ms = received_time - sent_time
			total_round_trip_time_ms += round_trip_time_ms
			total_round_trips_completed += 1
	
	if total_round_trips_completed != 0:
		return total_round_trip_time_ms / total_round_trips_completed
	else:
		return 0.0
		

