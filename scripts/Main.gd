extends Node


onready var hud            := get_node("HUD")
onready var obs_spawn      := get_node("Spawner_obsticles")
onready var bird           := get_node("Bird")
onready var menu_game_over := get_node("Menu/Game_Over_menu")
onready var menu           := get_node("Menu")

const SAVE_FILE_DATA_PATH := "user://highScoreData.save"

var score = 0 setget set_score
var high_score := 0

func _ready():
	obs_spawn.connect("on_obsticle_created",self,"_on_obsticles_created")
	bird.connect("game_started",self,"game_start")
	bird.connect("died",self,"game_over")
	load_data()

func game_start():
	self.score = 0
	obs_spawn.start()

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obsticles_created(obs):
	obs.connect("score",self,"player_score")


func game_over():
	obs_spawn.stop()
	get_tree().call_group("pillers","set_process",false)
	get_tree().call_group("ground","set_process",false)
	menu_game_over.visible = true

	if score > high_score:
		high_score = score
		save_data()

	menu.new_score(score,high_score)


func save_data():
	var file := File.new()
	file.open(SAVE_FILE_DATA_PATH,file.WRITE)
	file.store_var(high_score)
	file.close()

func load_data():
	var file := File.new()
	if file.file_exists(SAVE_FILE_DATA_PATH):
		file.open(SAVE_FILE_DATA_PATH,file.READ)
		high_score = file.get_var()
		file.close()
