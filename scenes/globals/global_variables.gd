extends Node

enum Platform {basic, trampoline, temporary, moving}

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

var player_height: int #pretty sure this is unused (set in player but not used anywhere)

var game_over_flag: bool = false

var is_window_set_correctly: bool = false
