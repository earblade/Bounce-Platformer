extends Platform

var tween: Tween

func _init():
	type = GlobalVariables.Platform.temporary
	bounce_height = -150
	max_spawn_rate = 4

func disappear():
	tween.tween_property($".", "modulate", Color.TRANSPARENT, 1.2)
	tween.tween_property($".", "collision_layer", 0, 0)

func _on_bounce():
	if not tween:
		tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
		disappear()
