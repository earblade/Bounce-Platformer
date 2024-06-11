extends Node2D
class_name PlayablePlatformsComponent

@export var available_platforms: AvailablePlatformsComponent
@export var player: CharacterBody2D

@export var max_platforms: int = 20
@export var platform_distance: int = -120

var bottom_offset: int = int(max_platforms / floor(5))
var top_offset: int = max_platforms-bottom_offset-1 #-1 is because get_index()
													#starts at 1
var lowest_platform

func init_platforms():
	while get_child_count() < max_platforms:

		var platform_scene = spawn_platform()
		move_platform(
			platform_scene,
			player.global_position.y +
			(platform_distance * platform_scene.get_index()) - platform_distance
		)

func iterate():
	for platform in get_children():
		var previous_platform = get_previous(platform)
		var top_platform = get_top(platform)

		if is_previous_current_lower(previous_platform, platform):
			if not previous_platform.visible:
				previous_platform.visible = true
				previous_platform.collision_layer = 3

			lowest_platform = get_child(
				(previous_platform.get_index()+1) % max_platforms
			)

			change_platform_spawn_chance()

			var new_platform = spawn_platform()
			move_platform(
				new_platform, top_platform.global_position.y
			)
			previous_platform.queue_free()


# player above both the previous platform and the current platform in the
# for loop
func is_previous_current_lower(previous, current):
	return current.global_position.y >= player.global_position.y \
		and previous.global_position.y >= player.global_position.y

func is_game_over():
	return lowest_platform.global_position.y <= player.global_position.y

# dunno how to make private but this needs to be private
# gets lowest platform in current iteration
func get_previous(current):
	return get_child(current.get_index() - bottom_offset)

func get_top(current):
	return get_child((current.get_index() + top_offset) % max_platforms)

func change_platform_spawn_chance():
	available_platforms.delete_platform()
	while available_platforms.get_child_count() != max_platforms:
		var rand_platform = GlobalVariables.Platform.values()[
			randi() % GlobalVariables.Platform.size()
		]
		if not available_platforms.is_max_spawn_rate(rand_platform):
			available_platforms.add_platform(rand_platform)

func move_platform(platform, anchor):
	var horizontal_range = randf_range(
		0 + platform.width/2,
		GlobalVariables.width - platform.width/2
	)
	platform.global_position = Vector2(
		horizontal_range,
		anchor + platform_distance
	)

func spawn_platform() -> Platform:
	var rand_platform = available_platforms.get_children()[
		randi() % available_platforms.get_child_count()
	]
	var platform = rand_platform.duplicate()

	add_child(platform)

	if get_child_count() == 1:
		platform.visible = false
		platform.collision_layer = 0
		lowest_platform = platform
	return platform
