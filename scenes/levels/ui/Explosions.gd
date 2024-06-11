extends Node2D


func play():
	for explosion in get_children():
		explosion.play("default")

func stop():
	for explosion in get_children():
		explosion.stop()
