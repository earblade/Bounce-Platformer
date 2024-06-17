extends Node2D

@export var baseUI: Control
@export var score: Label

var base_score_mult: int = 3
var total_change
var is_counting: bool = false


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
	container.rotation_degrees = clamp(rotation_adjusted_change, 0, 180)


func change_score_colour():
	var int_score = int(score.text)
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
