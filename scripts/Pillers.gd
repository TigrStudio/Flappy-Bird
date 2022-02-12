#script Pillers

extends Area2D

signal score

export var velocity := Vector2(50,0)

onready var score_snd = get_node("score_snd")

const PIPE_WIDTH := 42


func _process(delta):
	position -= velocity*delta
	if position.x <= PIPE_WIDTH*-1:
		queue_free()


func _on_score_detector_body_exited(body:Node):
	if body.is_in_group("Bird"):
		emit_signal("score")
		score_snd.play()
	else:
		return
	
