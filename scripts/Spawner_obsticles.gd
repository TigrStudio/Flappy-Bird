extends Node2D

signal on_obsticle_created(obs)

const pipe_scn   := preload("res://scenes/Pillers.tscn")
const PIPE_WIDTH := 82
const GROUND_HEIGHT := 56
const OFFSET_Y      := 56
const DIST_BETWEEN_PIPE := 26


onready var screen_size := get_viewport_rect().size
onready var container   := get_node("container") 
onready var timer       := get_node("spawn_timer")


func set_pos():
	randomize()
	var pos_init := position
	pos_init.x = (screen_size.x + PIPE_WIDTH / 2 )
	pos_init.y = rand_range(OFFSET_Y,screen_size.y - GROUND_HEIGHT - DIST_BETWEEN_PIPE - OFFSET_Y / 2)
	position = pos_init

func spawn_pipe():
	var new_pipe = pipe_scn.instance()
	new_pipe.position = position
	container.add_child(new_pipe)
	emit_signal("on_obsticle_created",new_pipe)


func _on_spawn_timer_timeout():
		set_pos()
		spawn_pipe()

func start():
	timer.start()

func stop():
	timer.stop()
