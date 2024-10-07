extends Node

@export var total_laps: int = 3
#@export var start_line_position: Vector2 = Vector2(579, 326)

var current_lap: int = 0
var race_started: bool = false
var is_finished: bool = false
var is_paused: bool = false
var bots: Array = []
var mainScence: Node
var pause_menu = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var current_scene = get_tree().current_scene
		if current_scene.name != "MainMenu":
			print("paused")
			pause_menu = current_scene.get_node("PauseMenu")
			pause_menu.toggle()

func complete_lap():
		current_lap += 1
		emit_signal("lap_completed", current_lap, total_laps)
		print("Lap " + str(current_lap) + " completed!")
		
		if current_lap >= total_laps:
			end_race()

func end_race():
	is_finished = true
	print("Race finished!")

func quit_game():
	print("Quitting game...")
	get_tree().quit()

func start_game():
	get_tree().change_scene_to_file("res://Scenes/kitchen_counter_track.tscn")

func back_to_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
func add_bot(bot):
	bots.append(bot)
