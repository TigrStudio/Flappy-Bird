extends CanvasLayer



onready var message = get_node("Start_Message/message")
onready var tween = get_node("Tween")
onready var score_label = get_node("Game_Over_menu/VBoxContainer/score_label")
onready var high_score_label = get_node("Game_Over_menu/VBoxContainer/high_score_label")
onready var restart_but = get_node("Game_Over_menu/VBoxContainer/restart")
onready var game_over_menu = get_node("Game_Over_menu")

func _ready():
	game_over_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func start_animation():
	tween.interpolate_property(message,"modulate:a",1,0,0.5)
	tween.start()

func _on_Bird_game_started():
	start_animation()

func new_score(score,high_score):
	score_label.text = "Score :" + " " +  str(score)
	high_score_label.text = "High Score :" + " " + str(high_score)

func _on_restart_pressed():
	get_tree().reload_current_scene()
