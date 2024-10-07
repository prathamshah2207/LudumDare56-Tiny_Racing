extends Node

signal lap_completed(current_lap, total_laps)
signal race_finished
signal game_paused
signal game_resumed

@export var total_laps: int = 3
@export var player_car_path: NodePath
@export var bot_car_scene: PackedScene
@export var number_of_bots: int = 4
@export var start_line_position: Vector2 = Vector2(579, 326)
@export var bot_spacing: float = 50.0

var current_lap: int = 0
var race_started: bool = false
var is_finished: bool = false
var is_paused: bool = false
var bots: Array = []

#@onready var player_car = get_node(player_car_path)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # Ensure this node isn't affected by pause

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
	elif event.is_action_pressed("quit"):
		quit_game()

func start_race():
	if not race_started:
		race_started = true
		current_lap = 0
		is_finished = false
		position_bots()
		# Additional race start logic (e.g., countdown, player controls enable)
		print("Race started!")

func position_bots():
	for i in range(number_of_bots):
		var bot_position = Vector2(start_line_position.x, start_line_position.y + i * bot_spacing)
		if i < bots.size():
			bots[i].position = bot_position
		else:
			print("Warning: Not enough bot instances available to position.")

func complete_lap():
	if race_started and not race_finished:
		current_lap += 1
		emit_signal("lap_completed", current_lap, total_laps)
		print("Lap " + str(current_lap) + " completed!")
		
		if current_lap >= total_laps:
			end_race()

func end_race():
	is_finished = true
	race_started = false
	emit_signal("race_finished")
	print("Race finished!")
	# Additional end race logic (e.g., show results screen, disable player controls)

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	if is_paused:
		emit_signal("game_paused")
		print("Game paused")
	else:
		emit_signal("game_resumed")
		print("Game resumed")

func quit_game():
	# Perform any cleanup or save operations here
	print("Quitting game...")
	get_tree().quit()

# Call this function when the player crosses the finish line
func player_crossed_finish_line():
	if race_started and not race_finished:
		complete_lap()

# Add bots to the bots array (call this when instantiating bots)
func add_bot(bot):
	bots.append(bot)
