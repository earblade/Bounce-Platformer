extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var top_margin: float = $Player/Camera2D.drag_top_margin
@onready var player = $Player
@onready var movable_objects = get_tree().get_nodes_in_group("Movable")


var gravity: int = -100

func _ready():

	print("height",height)
	print("width",width)



func _on_player_gravity(gravity):
	for platforms in movable_objects:
		platforms.position.y += gravity

