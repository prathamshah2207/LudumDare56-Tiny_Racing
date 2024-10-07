extends Node

@export var total_laps: int = 3
#@export var start_line_position: Vector2 = Vector2(579, 326)

var lap_count: Dictionary = {"Player": 0, "AIBot1": 0, "AIBot2": 0, "AIBot3": 0, "AIBot4": 0}

var racing: Array = ["Player", "AIBot1", "AIBot2", "AIBot3", "AIBot4"]
var ranking: Array = []

var current_lap: int = 0
var race_started: bool = false
var is_paused: bool = false
var mainScence: Node
var pause_menu = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var current_scene = get_tree().current_scene
		if current_scene.name != "MainMenu":
			print("paused")
			pause_menu = current_scene.get_node("PauseMenu")
			pause_menu.toggle()

func end_race():
	var level_complete = get_tree().root.find_child("LevelComplete", true, false)
	
	level_complete.find_child("Rank", true, false).text = "1. "+ranking[0]+"\n"+"2. "+ranking[1]+"\n"+"3. "+ranking[2]
	level_complete.visible = true
	Engine.time_scale = 0.1
	print("Race finished!")

func quit_game():
	print("Quitting game...")
	get_tree().quit()

func start_game():
	get_tree().change_scene_to_file("res://Scenes/kitchen_counter_track.tscn")

func back_to_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func add_lap(body: RigidBody2D):
	lap_count[body.name] += 1
	if lap_count[body.name] == 4:
		ranking.append(body.name)
		racing.erase(body.name)
		if body.name == "Player":
			for i in racing:
				if i == "Player":
					continue
				ranking.append(i)
			end_race()
