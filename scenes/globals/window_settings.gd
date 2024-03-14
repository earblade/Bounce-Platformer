extends Node

var monitor_res = DisplayServer.screen_get_size()
var width = monitor_res.x
var height = monitor_res.y

func get_window_width() -> int:
	var window_width = (width + 32) / 4 #need 32 offset
	return window_width

func get_window_height() -> int:
	var window_height = height/1.25
	return window_height
