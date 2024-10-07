extends RigidBody2D

@export var speed := randf_range(400.0, 600.0)  # Max speed
@export var acceleration := randf_range(150.0, 250.0)  # How fast it accelerates to max speed
@export var turn_speed := 5.0  # Max angular velocity for turning
@export var drift_threshold := 0.2  # Threshold for drifting
@export var drift_multiplier := 0.9
@export var min_distance_to_reach_waypoint := 50.0  # Distance threshold for waypoint switch

var current_waypoint : Node2D = null
var waypoint_manager : Node2D = null
@export var root_name : String = "Bot_TestScene"

var current_speed := 0.0  # Start speed at 0
var last_direction := Vector2.ZERO  # Store last direction for drifting

func _ready():
	# Dynamically search for WaypointManager in the scene tree
	get_tree().create_timer(0.1).connect("timeout", _start_moving)

func _start_moving():
	waypoint_manager = get_tree().root.get_node(root_name).find_child("WaypointManager", true, false)
	if waypoint_manager:
		current_waypoint = waypoint_manager.waypoints[0]  # Set the first waypoint
	else:
		print("Cannot find WaypointManager")

func _physics_process(delta: float):
	linear_velocity = Vector2.ZERO
	if current_waypoint:
		
		var closest_point = current_waypoint.get_closest_point_on_line(global_position)
		var direction_to_waypoint = closest_point - global_position
		var target_angle = global_position.angle_to_point(closest_point)

		# Calculate angle difference between current facing direction and the waypoint
		var angle_diff = target_angle - deg_to_rad(rotation_degrees - 90)
		angle_diff = wrapf(angle_diff, -PI, PI)  # Ensure the angle difference is within [-PI, PI]

		# Set angular velocity to turn the car based on angle difference
		angular_velocity = angle_diff * turn_speed
		
		# Gradually increase speed until max speed is reached
		current_speed = min(current_speed + acceleration * delta, speed)

		# Drifting and retaining speed in the previous direction while turning
		if abs(rad_to_deg(angular_velocity)) > drift_threshold:
			linear_velocity += last_direction * current_speed * drift_multiplier  # Drift effect: slightly reduce speed during drift
			linear_velocity += Vector2(0, -current_speed * 0.2).rotated(rotation)
		else:
			linear_velocity += Vector2(0, -current_speed).rotated(rotation)  # Normal speed when aligned

		# Update the last direction after moving
		last_direction = linear_velocity.normalized()

		# Switch to the next waypoint if close enough
		if global_position.distance_to(closest_point) < min_distance_to_reach_waypoint:
			#print(current_waypoint.name + " reached")
			current_waypoint = current_waypoint.get_next_waypoint()
