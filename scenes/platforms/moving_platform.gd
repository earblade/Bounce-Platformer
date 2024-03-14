extends Platform

@export var speed = 150
var direction = true #true is right false is left

func _init():

	type = GlobalVariables.Platform.moving
	max_spawn_rate = 8


func _physics_process(delta):

	if direction:
		position.x += delta*speed
	else:
		position.x -= delta*speed

	if position.x > 648:
		direction = false
	elif position.x < 0:
		direction = true


