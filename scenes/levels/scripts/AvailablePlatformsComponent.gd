class_name AvailablePlatformsComponent extends Node2D

@export var platforms: Dictionary = {
	GlobalVariables.Platform.basic:
	{
		"spawnrate": 20,
		"packedscene": preload(
			"res://scenes/platforms/bounce_platform.tscn"
		)
	},
	GlobalVariables.Platform.trampoline:
	{
		"spawnrate": 0,
		"packedscene": preload(
			"res://scenes/platforms/trampoline_platform.tscn"
		)
	},
	GlobalVariables.Platform.temporary:
	{
		"spawnrate": 0,
		"packedscene": preload(
			"res://scenes/platforms/temporary_platform.tscn"
		)
	},
}

func populate_available_platforms():
	for platform in platforms:
		for i in platforms[platform]["spawnrate"]:
			var platform_scene = platforms[platform]["packedscene"].instantiate()
			platform_scene.global_position = Vector2(-500, 0)
			add_child(platform_scene)

func add_platform(platform: GlobalVariables.Platform):
	# Add a platform to the node

	add_child(platforms[platform]["packedscene"].instantiate)


func delete_platform():
	var oldest_platform = get_child(0)
	oldest_platform.queue_free()

