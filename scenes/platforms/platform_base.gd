extends StaticBody2D

class_name Platform

signal bounce

var is_normal_bounced: bool = false
var is_super_bounced: bool = false
var type: GlobalVariables.Platform
var bounce_height: int = -150
var max_spawn_rate: int


@onready var width: int = $Sprite2D.scale.x
@onready var height: int = $Sprite2D.scale.y
