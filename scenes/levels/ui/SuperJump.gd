extends Control

@onready var font = $SuperJumpLabel.label_settings
@onready var style = $SuperJumpLabel.get_theme_stylebox("normal")

@export var animation: AnimationPlayer
@export var explosions: Node2D

## Called when the node enters the scene tree for the first time.
#func play_explosion():
#	$Explosion.play("default")

func change_sj_colour():
	var current_font_colour = font.font_color
	var target_colour = Color.from_hsv(
		fmod((current_font_colour.h + 0.1), 1.0),
		current_font_colour.s,
		current_font_colour.v,
		current_font_colour.a)
	var colour_roc = 0.02 # roc = rate of change
	while snapped(current_font_colour.h, 0.01) != snapped(target_colour.h, 0.01):
		current_font_colour.h -= colour_roc

		font.font_color.h = current_font_colour.h
		font.outline_color.h = current_font_colour.h
		style.border_color.h = current_font_colour.h
		style.shadow_color.h = current_font_colour.h

		await get_tree().create_timer(0.02).timeout

func player_super_jump():
	if animation.is_playing():
		animation.stop()
		explosions.stop()
	animation.play("new_sj")
