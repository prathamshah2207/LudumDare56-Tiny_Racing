extends CharacterBody2D

@export var speed := 300.0
var current_waypoint : Node2D = null
var waypoint_manager : Node2D = null
@export var root_name : String = "Bot_TestScene"
func _ready():
	# Dynamically search for WaypointManager in the scene tree
	waypoint_manager = get_tree().root.get_node(root_name).find_child("WaypointManager", true, false)
	if waypoint_manager:
		current_waypoint = waypoint_manager.waypoints[0]  # Set the first waypoint

func _physics_process(delta: float):
	if current_waypoint:
		var direction = (current_waypoint.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		if global_position.distance_to(current_waypoint.global_position) < current_waypoint.min_distance_to_reach_waypoint:
			current_waypoint = current_waypoint.get_next_waypoint()
