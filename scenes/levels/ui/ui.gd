extends Control

var initial_player_height: int

var total_score: int
var normal_jump_score: int = 0
var super_jump_score: int = 0
var max_height_score: int = 0


func score_counter():
	#TODO: add max height gained, every normal jump, and every super jump together
	#maybe through signals when each jump or super jump is had that adds to the score
	total_score = (
		normal_jump_score +
		super_jump_score +
		max_height_score
	)

	#tween this value to make the score increase relative to how much score was gained since last score
	$CenterContainer/Score.text = String.num_uint64(total_score)

func _on_player_normal_jump():
	normal_jump_score += 100
	score_counter()

func _on_player_super_jump(is_super_bounced):
	if not is_super_bounced:
		super_jump_score += 1000
		score_counter()

	var tween
	if not tween:

		tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property($SuperJump, "scale", Vector2.ONE, 0.2)
		tween.tween_property($SuperJump, "scale", Vector2.ZERO, 0.2)

func _on_player_max_height_change(height):
	max_height_score = -height + initial_player_height
	score_counter()


func _on_player_initial_height(height):
	initial_player_height = height
