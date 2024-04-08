extends Node2D

@onready var camera_offset: Vector2 = $Player/Camera2D.offset

@export var playable_platforms: PlayablePlatformsComponent
@export var available_platforms: AvailablePlatformsComponent


func _ready():

	DisplayServer.window_set_size(
		Vector2(
			WindowSettings.get_window_width(),
			WindowSettings.get_window_height()
		)
	)

	available_platforms.populate_available_platforms()

	playable_platforms.init_platforms()

func _process(_delta):

	# shoddy solution but works for now
	$Background.global_position.y = $Player.global_position.y

	for platforms in $AvailablePlatformsComponent.get_children():
		platforms.global_position.y = $Player.global_position.y + 1000

	if playable_platforms.is_game_over():
		pass

	playable_platforms.iterate()
