extends Node2D

const MAX_PLATFORMS = 20



var platform_distance: int = -120

@onready var camera_offset: Vector2 = $Player/Camera2D.offset
@onready var player = $Player

var lowest_platform

@export var playable_platforms: PlayablePlatformsComponent
@export var available_platforms: AvailablePlatformsComponent


func _ready():

	available_platforms.populate_available_platforms()

	playable_platforms.init_platforms()


func _process(_delta):

	$Background.global_position.y = player.global_position.y
	var bottom_offset = -4
	var top_offset = MAX_PLATFORMS+bottom_offset-1
	# we want to randomly generate platforms in a certain width a certain vertical
	# distance away from each other
	for platform in $PlayablePlatformsComponent.get_children():



		# the platform that will be moved to the top of the platforms & because of the
		# if elif statement, is the lowest platform
		var previous_platform = $PlayablePlatformsComponent.get_child(
			platform.get_index() + bottom_offset
		)

		# MAKE FUNCTION IN SEPERATE GAME OVER COMPONENT
		if playable_platforms.lowest_platform.global_position.y <= \
		player.global_position.y:
			game_over()

		# current top platform
		var top_platform = $PlayablePlatformsComponent.get_child(
			(platform.get_index() + top_offset) % MAX_PLATFORMS
		)

		# platform is the one the player has just passed
		if platform.global_position.y <= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:
			# CHANGE LATER
			if previous_platform.global_position.y > \
			playable_platforms.lowest_platform.global_position.y:
				lowest_platform = previous_platform

		# the platform 4 down is then moved to the top
		elif platform.global_position.y >= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:

			if not previous_platform.visible:
				previous_platform.visible = true
				previous_platform.collision_layer = 3


			lowest_platform = $PlayablePlatformsComponent.get_child(
				(previous_platform.get_index()+1) % MAX_PLATFORMS
			)
			playable_platforms.move_platform(
				previous_platform,
				top_platform.global_position.y
			)




func game_over():
	# TODO: Implement UI to say game over, show highscore and current score & option
	# to start over
	pass


