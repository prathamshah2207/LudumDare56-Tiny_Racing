extends RigidBody2D

@export var speed := 500.0  # Max speed
@export var acceleration := 200.0  # How fast it accelerates to max speed
@export var turn_speed := 5.0  # Max angular velocity for turning
@export var drift_threshold := 0.2  # Threshold for drifting
@export var min_distance_to_reach_waypoint := 10.0  # Distance threshold for waypoint switch

var current_waypoint : Node2D = null
var waypoint_manager : Node2D = null
@export var root_name : String = "Bot_TestScene"

var current_speed := 0.0  # Start speed at 0
var last_direction := Vector2.ZERO  # Store last direction for drifting

func _ready():
	get_tree().create_timer(0.1).connect("timeout", _start_moving)

func _start_moving():
	waypoint_manager = get_tree().root.get_node(root_name).find_child("WaypointManager", true, false)
	if waypoint_manager:
		current_waypoint = waypoint_manager.waypoints[0]
	else:
		print("Cannot find WaypointManager")

func _physics_process(delta: float):
	linear_velocity = Vector2.ZERO
	if current_waypoint:
		var direction_to_waypoint = current_waypoint.global_position - global_position
		var target_angle = global_position.angle_to_point(current_waypoint.global_position)

		# Calculate angle difference between current facing direction and the waypoint
		var angle_diff = target_angle - deg_to_rad(rotation_degrees - 90)
		angle_diff = wrapf(angle_diff, -PI, PI)  # Ensure the angle difference is within [-PI, PI]

		# Set angular velocity to turn the car based on angle difference
		angular_velocity = angle_diff * turn_speed
		
		print(rad_to_deg(angular_velocity))
		# Gradually increase speed until max speed is reached
		current_speed = min(current_speed + acceleration * delta, speed)

		# Drifting and retaining speed in the previous direction while turning
		if abs(angular_velocity) > drift_threshold:
			linear_velocity += last_direction * current_speed * 0.8  # Drift effect: slightly reduce speed during drift
			linear_velocity += Vector2(0, -current_speed * 0.2).rotated(rotation)
		else:
			linear_velocity += Vector2(0, -current_speed).rotated(rotation)  # Normal speed when aligned

		# Update the last direction after moving
		last_direction = linear_velocity.normalized()

		# Switch to the next waypoint if close enough
		if global_position.distance_to(current_waypoint.global_position) < min_distance_to_reach_waypoint:
			print(current_waypoint.name + " reached")
			current_waypoint = current_waypoint.get_next_waypoint()
