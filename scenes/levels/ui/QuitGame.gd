extends Button


func _on_pressed():
	$ConfirmationDialog.visible = true

func _on_confirmation_dialog_confirmed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

func _on_confirmation_dialog_canceled():
	$ConfirmationDialog.visible = false
