extends CanvasLayer

onready var score_label = get_node("Score")


func update_score(new_score):
	score_label.text = str(new_score)