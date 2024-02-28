extends Platform

@export var speed = 300

func _init():
	type = GlobalVariables.Platform.moving
	max_spawn_rate = 8

