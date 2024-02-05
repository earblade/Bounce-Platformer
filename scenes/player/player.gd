extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var is_falling: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	if velocity.y > 0:
		is_falling = true
	else:
		is_falling = false

	print(velocity)
	# Add the gravity.
	if not is_on_floor() and $JumpTimer.is_stopped():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		$JumpTimer.start()
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_falling:
		$JumpTimer.stop()
		velocity.y = 0 # super meat boy jumping except im pretty sure smb has an acceleration for thier 		jumping

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		# potential optimisation is getting the collision once and putting it in an array instead of 		finding the same collision over and over again, but not sure if it would save anything too drastic
		var platform = collision.get_collider()
		# looks at case where if player is on the platform it will rise, and if the player is at the 		beginning of their jump just when they collide, add the bounce velocity
		if is_on_floor():
			velocity.y = platform.bounce_velocity
