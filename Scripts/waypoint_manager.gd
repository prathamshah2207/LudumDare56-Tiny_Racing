extends Node2D

var waypoints = []

func _ready():
	# Get all waypoints under the WaypointManager node
	waypoints = get_children()
	#print(waypoints)
	
	# Link waypoints
	for i in range(waypoints.size() - 1):
		waypoints[i].set_next_waypoint(waypoints[i + 1])
	
	# Optionally loop the last waypoint to the first
	waypoints[waypoints.size() - 1].set_next_waypoint(waypoints[0])

#func _draw():
	## Draw lines between waypoints for visualization
	#for i in range(waypoints.size() - 1):
		#draw_line(waypoints[i].global_position, waypoints[i + 1].global_position, Color(1, 0, 0), 2)
	## Optionally draw a line from the last to the first waypoint
	#draw_line(waypoints[waypoints.size() - 1].global_position, waypoints[0].global_position, Color(0, 1, 0), 2)
