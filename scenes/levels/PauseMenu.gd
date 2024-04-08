extends CanvasLayer

func is_paused():
	if Input.is_action_just_pressed("pause"):
		return true

func _process(_delta):

	if is_paused():
		visible = not visible
		get_tree().paused = not get_tree().paused
