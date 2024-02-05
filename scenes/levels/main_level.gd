extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var top_margin: float = $Player/Camera2D.drag_top_margin
@onready var player = $Player
@onready var movable_objects = get_tree().get_nodes_in_group("Movable")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var platform_velocity: Vector2 #the platforms move under the player; the player should be roughly still in the center of the screen

var is_on_floor: bool

func _ready():

	print(movable_objects)
	print("height",height)
	print("width",width)

func _physics_process(delta):

	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		platform_velocity.y = player.jump_height
		is_on_floor = false


	platform_velocity.y -= gravity * delta

	for platforms in $Platforms.get_children():

		var collision = platforms.move_and_collide(platform_velocity * delta)
		if collision:
			is_on_floor = true
			platform_velocity = Vector2.DOWN * platforms.bounce_speed


