extends Node2D

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var top_margin: float = $Player/Camera2D.drag_top_margin

@onready var offset: int = $Background2.position.x - $Background.position.x - width
#False means on left side, true means on right side
var teleport: bool = false

func _ready():
	print("offset",offset)
	print("height",height)
	print("width",width)

func _on_backwards_tele_body_entered(_body):
	if not teleport:
		teleport = true
		$Player/Camera2D.limit_right = width*2 + offset
		$Player/Camera2D.limit_left = width + offset
		$Player.position.y = $Teleports/TeleportPositions/BackwardsTele1Pos.position.y
		$Player.position.x += width + offset
		$Player/Camera2D2.make_current()

	else:
		teleport = false
		$Player/Camera2D.limit_left = 0
		$Player/Camera2D.limit_right = width
		$Player.position.y = $Teleports/TeleportPositions/BackwardsTele2Pos.position.y
		$Player.position.x -= width + offset
		$Player/Camera2D.make_current()



func _on_tele_body_entered(_body):
	if not teleport:
		teleport = true
		$Player/Camera2D2.limit_right = width*2 + offset
		$Player/Camera2D2.limit_left = width + offset
		$Player/Camera2D2.limit_bottom = 1000000
		$Player/Camera2D2.offset.y = -280

		$Player.position.y = $Teleports/TeleportPositions/Tele1Pos.position.y
		$Player.position.x += width + offset

		$Player/Camera2D2.make_current()

		await get_tree().process_frame
		$Player/Camera2D2.offset.y = -450
#		print("y ",$Player.position.y)
#		print("x ",$Player.position.x)
	else:
		teleport = false
		$Player/Camera2D.limit_left = 0
		$Player/Camera2D.limit_right = width
		$Player.position.y = $Teleports/TeleportPositions/Tele2Pos.position.y
		$Player.position.x -= width + offset
		$Player/Camera2D.make_current()
