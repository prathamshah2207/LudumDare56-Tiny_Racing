extends Camera2D

@export var initial_position = Vector2(578, 323)  # Initial camera position
@export var move_speed = 10.0  # Speed to move to the target
var zoom_effect := 0.01
@export var final_zoom = Vector2(2.0, 2.0)  # Zoom level at start (zoomed out)
@export var normal_time_scale = 1.0  # Normal timescale
var moving_to_target = false

func _ready():
	# Set the initial position and zoom
	global_position = initial_position
	zoom = Vector2(1.0, 1.0)

	# Set a slower time scale to emphasize the zoomed-out effect
	Engine.time_scale = 0.1
	get_tree().create_timer(0.05).connect("timeout", _start_moving)

func _start_moving():
	moving_to_target = true

func _process(delta):
	if moving_to_target:
		# Calculate the direction to move towards (0, 0)
		var direction = position.direction_to(Vector2(0,0))
		
		# Move the camera in the direction with the given speed
		position += direction * move_speed
		if zoom < final_zoom:
			zoom += Vector2(zoom_effect, zoom_effect)
		# Stop moving if we have reached the target position or are very close
		if (position <= Vector2(0.01, 0.01)):
			moving_to_target = false  # Stop further movement

			Engine.time_scale = 1
