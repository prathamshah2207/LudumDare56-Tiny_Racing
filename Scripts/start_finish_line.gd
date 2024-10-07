extends Area2D



func _on_body_entered(body: RigidBody2D) -> void:
	print(body.name)
	GameManager.add_lap(body)
