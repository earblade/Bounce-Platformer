extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var top_margin: float = $Player/Camera2D.drag_top_margin


func _ready():

	print("height",height)
	print("width",width)
