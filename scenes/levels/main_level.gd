extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var basic_platform: PackedScene = preload("res://scenes/platforms/bounce_platform.tscn")
var platform_distance: int = -120

@onready var camera_offset: Vector2 = $Player/Camera2D.offset
@onready var player = $Player

var platforms: Array

func _ready():

	platforms.push_front(basic_platform)
	spawn_platforms() #using basic platform currently

func _process(_delta):

	$Background.global_position.y = player.global_position.y

	# we want to randomly generate platforms in a certain width a certain vertical distance away from each other



	for platform in $Platforms.get_children():
		var previous_platform = $Platforms.get_child(platform.get_index()-4)

		var top_platform = $Platforms.get_child((platform.get_index()+15)%20)
		if platform.global_position.y >= player.global_position.y \
		and previous_platform.global_position.y >= player.global_position.y:
			move_platform(previous_platform, top_platform.global_position.y)


func move_platform(platform, anchor):
	var horizontal_range = randf_range(0 + platform.width/2, width - platform.width/2)
	platform.global_position = Vector2(
		horizontal_range,
		anchor + platform_distance)

func spawn_platforms():
	while $Platforms.get_child_count() < 20: # 20 basic platforms including the ground
		var platform_scene = basic_platform.instantiate()
		$Platforms.add_child(platform_scene)
		move_platform(
			platform_scene,
			player.global_position.y + (platform_distance * platform_scene.get_index())
		)

