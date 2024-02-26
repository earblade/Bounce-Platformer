extends StaticBody2D

class_name Platform

var bounce_height: int
var max_spawn_rate: int

@onready var width: int = $Sprite2D.scale.x
@onready var height: int = $Sprite2D.scale.y
