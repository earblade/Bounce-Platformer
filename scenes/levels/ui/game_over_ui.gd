extends Control

signal reset_scene()

func _ready():
	pass

func _on_try_again_pressed():
	get_tree().reload_current_scene()
	GlobalVariables.game_over_flag = false


func _on_quit_game_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
