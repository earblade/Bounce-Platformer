extends Control

signal change_score(score)

func _on_score_control_change_score(score):
	emit_signal("change_score", score)
