extends Control

const base_score_mult = 3

var total_score: int

@export var score: Label
var score_animation


func _ready():
	score_animation = animate_score.new(score)

func score_counter(value):
### Activates whenever the score is able to be changed. Meaning that every action
### inside this function needs to occur every time the score changes

	var old_total_score = total_score

	total_score += value

	if score_animation.is_counting:
		score_animation.add_total_change(old_total_score, total_score)
	else:
		score_animation.animate_total_score(old_total_score, total_score)

func _on_player_normal_jump():
	var normal_jump_score = 100 * base_score_mult

	score_counter(normal_jump_score)

func _on_player_super_jump(is_super_bounced):
	if not is_super_bounced:
		var super_jump_score = 1000 * base_score_mult
		score_counter(super_jump_score)

	$SuperJump.player_super_jump()


func _on_player_max_height_change():
	var max_height_score = 1 * base_score_mult
	score_counter(max_height_score)

func _on_cheats_change_score(score):
	score_counter(score)


class animate_score:
	extends "ui.gd"

	var total_change
	var is_counting: bool = false

	func _init(i_score): #i_score is initialised score
		score = i_score


	func add_total_change(old, new):
		total_change += new - old

	func rotate_and_scale():

		var size_adjusted_change
		var rotation_adjusted_change

		size_adjusted_change = 50 + log(total_change) * 10
#		print("size_adjusted_change: ", size_adjusted_change)
		score.label_settings.font_size = clamp(size_adjusted_change, 70, 150)

		var container = score.get_parent()

		container.pivot_offset = container.size/2

		rotation_adjusted_change = log(total_change) * 8 - 20
#		print("rotation_adjusted_change: ", rotation_adjusted_change)
		container.rotation_degrees = clamp(rotation_adjusted_change, 0, 120)


	func change_score_colour():
		var int_score = int(score.text)
		print("int_score: ", int_score)
		if int_score < 100_000:
			var weight = float(int_score)/100_000
			score.label_settings.font_color = Color.WHITE.lerp(
											Color.SKY_BLUE, weight)
		if int_score > 100_000 && int_score < 150_000:
			var weight = float(int_score - 100_000) / 50_000
			score.label_settings.font_color = Color.SKY_BLUE.lerp(
											Color.BLUE, weight)
		if int_score > 150_000 && int_score < 250_000:
			var weight = float(int_score - 150_000) / 100_000
			score.label_settings.font_color = Color.BLUE.lerp(
											Color.DARK_BLUE, weight)
		if int_score > 250_000 && int_score < 300_000:
			var weight = float(int_score - 250_000) / 50_000
			score.label_settings.font_color = Color.DARK_BLUE.lerp(
											Color.REBECCA_PURPLE, weight)
		if int_score > 300_000 && int_score < 350_000:
			var weight = float(int_score - 300_000) / 50_000
			score.label_settings.font_color = Color.REBECCA_PURPLE.lerp(
											Color.DARK_SLATE_GRAY, weight)
		if int_score > 350_000 && int_score < 400_000:
			var weight = float(int_score - 350_000) / 50_000
			score.label_settings.font_color = Color.DARK_SLATE_GRAY.lerp(
											Color.BLACK, weight)

	func animate_total_score(old, new):
		var timer_length: float
		total_change = new - old
		var offset = 0

		is_counting = true
		while total_change != 0:
			var offset_roc = 0

			if total_change > 10000:
				offset_roc = 10 * base_score_mult
			elif total_change > 5000:
				offset_roc = 8 * base_score_mult
			elif total_change > 1000:
				offset_roc = 4 * base_score_mult
			elif total_change > 100:
				offset_roc = 2 * base_score_mult
			else:
				offset_roc = 1

			if offset == 0:
				timer_length = 0.11
			else:
				timer_length = 1.0/total_change*2.0

#			print("total_change: ", total_change)

			offset += offset_roc
			total_change -= offset_roc
			score.text = String.num_uint64(old+offset)
			change_score_colour()

			rotate_and_scale()
			await Engine.get_main_loop().create_timer(timer_length).timeout
		is_counting = false
