extends Control



var base_score_mult
var total_score: int

@export var animateScore: Node2D

func _ready():
	base_score_mult = animateScore.base_score_mult

func score_counter(value):
### Activates whenever the score is able to be changed. Meaning that every action
### inside this function needs to occur every time the score changes

	var old_total_score = total_score

	total_score += value

	if animateScore.is_counting:
		animateScore.add_total_change(old_total_score, total_score)
	else:
		animateScore.animate_total_score(old_total_score, total_score)

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

func _on_cheats_change_score(cheated_score):
	score_counter(cheated_score)
