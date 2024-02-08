extends CharacterBody2D


const SPEED = 300.0
const JUMP_HEIGHT = -150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bounce_height = 0

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = initial_velocity(JUMP_HEIGHT)
		#v = u + gt
		#t = v-u/g @ v = 0 (peak height)
		$JumpTimer.wait_time = -velocity.y/gravity
		$JumpTimer.start()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		var platform = collision.get_collider()
		#bounce when it needs to bounce
		if "bounce_height" in platform and is_on_floor():
			bounce_height = platform.bounce_height
			velocity.y = initial_velocity(bounce_height)
			$BounceTiming.start()

	#super jump
	if Input.is_action_just_pressed("jump") and not $BounceTiming.is_stopped():
		print("super jump")
		velocity.y = initial_velocity(bounce_height + JUMP_HEIGHT + jump_offset())

# so that every super jump gets the same jump height (even at different timings)
func jump_offset() -> float:
	#s = u*t + 1/2*g*t**2
	var offset = (
		initial_velocity(bounce_height + JUMP_HEIGHT) * ($BounceTiming.time_left - $BounceTiming.wait_time) +
		1/2.0 * gravity * ($BounceTiming.time_left - $BounceTiming.wait_time) ** 2
		)
	print(offset)
	return offset

# u**2 = -2*g*s
func initial_velocity(height) -> float:
	var vel = sqrt(-2*gravity*height)
	vel = -vel
	return vel

func is_falling() -> bool:
	if velocity.y > 0:
		return true
	else:
		return false



func _on_bounce_timing_timeout():
	bounce_height = 0
