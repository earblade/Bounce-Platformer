extends CharacterBody2D

signal normal_jump
signal super_jump(is_super_bounced)
signal max_height_change()
#signal initial_height(height)

const SPEED = 300.0
const JUMP_HEIGHT = -160

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bounce_height = 0
var max_height: float
var floor_platform


func _ready():
	max_height = position.y
#	emit_signal("initial_height", max_height)

func _physics_process(delta):

	if max_height > position.y:
		max_height = position.y
		emit_signal("max_height_change") #, max_height
#		GlobalVariables.player_height = position.y

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = initial_velocity(JUMP_HEIGHT)
		#v = u + gt
		#t = v-u/g @ v = 0 (peak height)

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
		if platform is Platform:
			floor_platform = platform
		else:
			floor_platform = null

	if is_on_floor() and $JumpDebounceTimer.is_stopped() and floor_platform != null:
		bounce_height = floor_platform.bounce_height
		floor_platform.emit_signal("bounce")
		if not floor_platform.is_normal_bounced:
			emit_signal("normal_jump")
			floor_platform.is_normal_bounced = true
		velocity.y = initial_velocity(bounce_height)
		$JumpDebounceTimer.start()
		$BounceTiming.start()


	#super jump
	if Input.is_action_just_pressed("jump") and not $BounceTiming.is_stopped() \
	and floor_platform != null:
		print("superjump")
		print(floor_platform.is_super_bounced)
		emit_signal("super_jump", floor_platform.is_super_bounced)
		velocity.y = initial_velocity(bounce_height + JUMP_HEIGHT +
		jump_offset() + 30)
		floor_platform.is_super_bounced = true
#	print($BounceTiming.time_left)

# so that every super jump gets the same jump height (even at different timings)
# DOES NOT WORK, just inverses the amount of height you get the earlier you jump
# eg. earlier timings are rewarded with a higher jump
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
