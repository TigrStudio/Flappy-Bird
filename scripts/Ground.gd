extends StaticBody2D

const GROUND_HEIGHT := 56
const GROUND_WIDTH  := 168

onready var screen := get_viewport_rect().size
onready var sprite_1 := get_node("Sprite1")
onready var sprite_2 := get_node("Sprite2")

export var speed := Vector2(1,0)


func _ready():
	sprite_1.position = Vector2(0,0)
	sprite_2.position = Vector2(GROUND_WIDTH,0)
	position = Vector2(0,screen.y - GROUND_HEIGHT)


func _process(delta):
	move(delta)


func move(time):
	if sprite_1.position.x < -168:
		sprite_1.position.x = 165
	if sprite_2.position.x < -168:
			sprite_2.position.x = 165
	sprite_1.position -= speed
	sprite_2.position -= speed
