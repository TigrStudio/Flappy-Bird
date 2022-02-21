#script bird
extends RigidBody2D

signal game_started
signal died

onready var screen := get_viewport_rect().size
onready var anim = get_node("AnimatedSprite")
onready var camera := get_node("Camera2D")
onready var particles := get_node("Particles")
onready var hit_snd := get_node("hit")
onready var wing_snd := get_node("wing")

export var jump_speed := -150

const bird_animation_list := ["bird_blue","bird_orange","bird_red"]

var alive := false
var started := false

#_______________func_______________________________

func _ready():
	set_new_anim()
	set_initial_value()
	particles.set_emitting(false)

func _process(_delta):

	if Input.is_action_just_pressed("flap") and not started:
		set_final_value()
		emit_signal("game_started")
		particles.set_emitting(true)

	if !alive:
		return

	if Input.is_action_just_pressed("flap") and alive:
			flap()
			wing_snd.play()

	if rotation_degrees < -30:
		rotation_degrees = -30
		angular_velocity = 0

	if linear_velocity.y > 0:
		angular_velocity = 1.5

func flap():
	linear_velocity = Vector2(linear_velocity.x,jump_speed)
	angular_velocity = -1.5
		
func set_initial_value():
	gravity_scale = 0
	position = Vector2(int(screen.x*0.15),screen.y /2)
	linear_velocity = Vector2()
	angular_velocity = 0
	alive = false

func set_final_value():
		gravity_scale = 6
		alive = true
		started = true
	
func set_new_anim():
	randomize()
	anim.animation = bird_animation_list[rand_range(0,3)]
	anim.playing = true

func _on_collision_detector_area_entered(area:Area2D):
	if (area.is_in_group("pillers")):
		emit_signal("died")
		die()

func _on_Bird_body_entered(body:Node):
	if body.is_in_group("ground"):
		emit_signal("died")
		die()

func die():
	if alive:
		hit_snd.play()
	alive = false
	anim.playing = false
	particles.set_emitting(false)
