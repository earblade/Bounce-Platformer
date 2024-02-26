extends Node

enum Platform {basic, trampoline, temporary, moving}

var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")

