extends Area2D

func _on_body_entered(body: RigidBody2D) -> void:
	#print(body.name, "entered")
	body.speed /= 4.0


func _on_body_exited(body: RigidBody2D) -> void:
	#print(body.name, "exited")
	body.speed *= 4.0
