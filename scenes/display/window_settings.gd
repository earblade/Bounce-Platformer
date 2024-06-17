extends Node

var monitor_res = DisplayServer.screen_get_size()
var width = monitor_res.x
var height = monitor_res.y

func _ready():

	var window = get_window()

	if not GlobalVariables.is_window_set_correctly:
		window.position = Vector2i(
			window.position.x - floor(get_window_width()/2.0) + 81, #needs to be relative (if using dual monitors)
			height * 0.1 # doesnt work properly if launched on a second smaller monitor that does not include the 0,0 start point (will need to find a relation with window.position.y to fix this)
			#also 0.1 is very important, on my 2k monitor, 0.2 is 288 which is the difference between 1440 and 1152, so half that would spread the difference across the top and bottom of the screen
		)

		window.size = Vector2(
			get_window_width(),
			get_window_height()
		)

		GlobalVariables.is_window_set_correctly = true

func get_window_width() -> int:
	var window_width = (width + 32) / 4
	return window_width

func get_window_height() -> int:
	var window_height = height / 1.25
	return window_height
