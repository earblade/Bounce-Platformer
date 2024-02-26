extends Node2D

const MAX_PLATFORMS = 20

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var basic: PackedScene = preload("res://scenes/platforms/bounce_platform.tscn")
var tramp: PackedScene = preload("res://scenes/platforms/trampoline_platform.tscn")
var temp: PackedScene = preload("res://scenes/platforms/temporary_platform.tscn")
var platform_distance: int = -120

enum Platform {basic, trampoline, explode, moving}

@onready var camera_offset: Vector2 = $Player/Camera2D.offset
@onready var player = $Player

var platforms: Dictionary #contains every platform and their chance to be chosen
var lowest_platform


func _ready():
	platforms = {
		basic: 20,
		tramp: 0,
		temp: 0,
	}

	for base_platform in platforms:
		for i in platforms[base_platform]:
			var base_platform_child = base_platform.instantiate()
			base_platform_child.global_position = Vector2(-500, 0)
			$AvailablePlatforms.add_child(base_platform_child)

	while $Platforms.get_child_count() < MAX_PLATFORMS:
		# 20 platforms plus the ground

		var platform_scene = spawn_platform()
		move_platform(
			platform_scene,
			player.global_position.y +
			(platform_distance * platform_scene.get_index()) -
			platform_distance
		)


func _process(_delta):

	$Background.global_position.y = player.global_position.y

	# we want to randomly generate platforms in a certain width a certain vertical
	# distance away from each other
	for platform in $Platforms.get_children():

		var bottom_offset = -4
		var top_offset = 15

		# the platform that will be moved to the top of the platforms & because of the
		# if elif statement, is the lowest platform
		var previous_platform = $Platforms.get_child(
			platform.get_index() + bottom_offset
		)

		if lowest_platform.global_position.y <= player.global_position.y:
			game_over()

		# current top platform
		var top_platform = $Platforms.get_child(
			(platform.get_index() + top_offset) % MAX_PLATFORMS
		)

		# platform is the one the player has just passed
		if platform.global_position.y <= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:
			if previous_platform.global_position.y > lowest_platform.global_position.y:
				lowest_platform = previous_platform

		# the platform 4 down is then moved to the top
		elif platform.global_position.y >= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:
			if not previous_platform.visible:
				previous_platform.visible = true
				previous_platform.collision_layer = 3
			lowest_platform = $Platforms.get_child(
				(previous_platform.get_index()+1) % MAX_PLATFORMS
			)
			move_platform(previous_platform, top_platform.global_position.y)



func game_over():
	# TODO: Implement UI to say game over, show highscore and current score & option
	# to start over
	pass

func move_platform(platform, anchor):
	var horizontal_range = randf_range(0 + platform.width/2, width - platform.width/2)
	platform.global_position = Vector2(
		horizontal_range,
		anchor + platform_distance
	)

func spawn_platform() -> Node:
	var rand_platform
	var rand_number = randi_range(1, MAX_PLATFORMS)
	for platform in $AvailablePlatforms.get_children():
		if platform.max_spawn_rate >= rand_number:
			# TODO: maxspawnrate needs to be changed to just spawn rate
			rand_platform = platform.duplicate()

	$Platforms.add_child(rand_platform)

	if $Platforms.get_child_count() == 1:
		rand_platform.visible = false
		rand_platform.collision_layer = 0
		lowest_platform = rand_platform
	return rand_platform

