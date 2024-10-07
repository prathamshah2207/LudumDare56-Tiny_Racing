extends Area2D

# Signal to notify when a racer crosses the line
signal racer_crossed(racer)


func _ready() -> void:
	# Connect the body_entered signal to a function
	#connect("body_entered", self, "_on_body_entered")
	pass

func _on_body_entered(body):
	# Checks if the body is a racer (you might want to check for a specific group or property)
	if body.is_in_group("racers"):
		# Emit a signal or perform an action when a racer crosses
		emit_signal("racer_crossed", body)
		# Optionally, print to console for debugging
		print("Racer crossed the start/finish line: ", body.name)
