extends Platform

func _init():
	bounce_height = -150
	max_spawn_rate = 4

func disappear():
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 1)
	tween.tween_callback($".".queue_free)

