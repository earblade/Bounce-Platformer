class_name AvailablePlatformsComponent extends Node2D

@export var platforms: Dictionary = {
	GlobalVariables.Platform.basic:
	{
		"spawnrate": 20,
		"maxspawnrate": 20,
		"packedscene": preload("res://scenes/platforms/bounce_platform.tscn")
	},
	GlobalVariables.Platform.trampoline:
	{
		"spawnrate": 0,
		"maxspawnrate": 4,
		"packedscene": preload("res://scenes/platforms/trampoline_platform.tscn")
	},
	GlobalVariables.Platform.temporary:
	{
		"spawnrate": 0,
		"maxspawnrate": 4,
		"packedscene": preload("res://scenes/platforms/temporary_platform.tscn")
	},
	GlobalVariables.Platform.moving:
	{
		"spawnrate": 0,
		"maxspawnrate": 12,
		"packedscene": preload("res://scenes/platforms/moving_platform.tscn")
	}
}

func populate_available_platforms() -> void:

	for platform in platforms:
		for i in platforms[platform]["spawnrate"]:
			var platform_scene = platforms[platform]["packedscene"].instantiate()
#			platform_scene.global_position = Vector2(-500, 0)
			add_child(platform_scene)

func add_platform(platform: GlobalVariables.Platform) -> void:
	# Add a platform to the node
	platforms[platform]["spawnrate"] += 1
	var new_platform = platforms[platform]["packedscene"].instantiate()
	new_platform.global_position = Vector2(-500, 0)
	add_child(new_platform)

func delete_platform() -> void:
	var oldest_platform: Platform = get_child(0)
	platforms[oldest_platform.type]["spawnrate"] -= 1
	oldest_platform.queue_free()

func is_max_spawn_rate(platform: GlobalVariables.Platform) -> bool:
	return platforms[platform]["spawnrate"] == platforms[platform]["maxspawnrate"]
