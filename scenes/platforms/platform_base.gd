extends StaticBody2D

class_name Platform

signal bounce

var type: GlobalVariables.Platform
var bounce_height: int = -150
var max_spawn_rate: int


@onready var width: int = $Sprite2D.scale.x
@onready var height: int = $Sprite2D.scale.y
