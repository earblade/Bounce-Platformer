extends CharacterBody2D

signal gravity(rate)

var speed: int = 250

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		gravity.emit(1)

	if not is_on_floor():
		gravity.emit(-1)


	move_and_slide()
