extends CanvasLayer

func is_paused():
	if Input.is_action_just_pressed("debug_menu"):
		return true

func _process(_delta):

	if is_paused():
		visible = not visible
