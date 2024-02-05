extends CharacterBody2D

var jump_height = 600
var speed: int = 350

func _physics_process(delta):

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	move_and_collide(velocity * delta)
