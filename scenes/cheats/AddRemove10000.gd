extends CenterContainer

signal change_score(score)

func _on_add_pressed():
	emit_signal("change_score", 10_000)

func _on_remove_pressed():
	emit_signal("change_score", -10_000)
