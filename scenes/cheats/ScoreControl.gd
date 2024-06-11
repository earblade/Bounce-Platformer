extends Control

signal change_score(score)

func _on_add_remove_10000_change_score(score):
	emit_signal("change_score", score)


func _on_add_remove_20000_change_score(score):
	emit_signal("change_score", score)
