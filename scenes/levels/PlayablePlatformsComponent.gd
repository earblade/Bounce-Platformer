class_name PlayablePlatformsComponent extends Node2D

const MAX_PLATFORMS = 20

var platform_distance: int = -120
var lowest_platform
@export var available_platforms: AvailablePlatformsComponent

@onready var player = $"../Player" # TEMPORARY MEASURE


func init_platforms():
	while get_child_count() < MAX_PLATFORMS:
		# 20 platforms plus the ground

		var platform_scene = spawn_platform()
		move_platform(
			platform_scene,
			player.global_position.y +
			(platform_distance * platform_scene.get_index()) -
			platform_distance
		)

func move_platform(platform, anchor):
	var horizontal_range = randf_range(
		0 + platform.width/2,
		GlobalVariables.width - platform.width/2
	)
	platform.global_position = Vector2(
		horizontal_range,
		anchor + platform_distance
	)

func spawn_platform() -> Node:
	var rand_platform
	var rand_number = randi_range(1, MAX_PLATFORMS)
	for platform in available_platforms.get_children():
		if platform.max_spawn_rate >= rand_number:
			# TODO: maxspawnrate needs to be changed to just spawn rate
			rand_platform = platform.duplicate()

	add_child(rand_platform)

	if get_child_count() == 1:
		rand_platform.visible = false
		rand_platform.collision_layer = 0
		lowest_platform = rand_platform
	return rand_platform
