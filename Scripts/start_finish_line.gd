extends Area2D



func _on_body_entered(body: RigidBody2D) -> void:
	print(body.name, "just passed finish line")
