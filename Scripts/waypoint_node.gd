extends Node2D

@export var min_distance_to_reach_waypoint := 5.0
var next_waypoint : Node2D = null

func set_next_waypoint(next: Node2D):
	next_waypoint = next
	
func get_next_waypoint():
	return next_waypoint
