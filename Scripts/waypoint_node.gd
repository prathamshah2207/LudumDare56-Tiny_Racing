extends Node2D

var next_waypoint : Node2D = null
@onready var line_2d: Line2D = $Line2D
var start_point: Vector2
var end_point: Vector2

func _ready() -> void:
	start_point = global_position + line_2d.points[0]
	end_point = global_position + line_2d.points[1]
	line_2d.visible = false

func set_next_waypoint(next: Node2D):
	next_waypoint = next
	
func get_next_waypoint():
	return next_waypoint

func get_closest_point_on_line(bot_position: Vector2) -> Vector2:
	var line_direction = end_point - start_point
	var line_length_squared = line_direction.length_squared()
	
	# If the line segment is a point, return the start point
	if line_length_squared == 0:
		return global_position
		
	# Calculate the projection of the bot's position onto the line segment
	var t = (bot_position - start_point).dot(line_direction) / line_length_squared
	t = clamp(t, 0.0, 1.0)  # Clamp the value to ensure it stays within the segment bounds
	
	# Compute the closest point on the line segment
	var closest_point = start_point + t * line_direction
	return closest_point
