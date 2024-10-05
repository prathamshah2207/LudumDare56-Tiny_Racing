extends CharacterBody2D

@export var speed := 500.0
@export var boost_speed := 800.0
var boost_available := false

func _physics_process(delta: float) -> void:
	move_bot(delta)

func move_bot(delta):
	var direction = Vector2.ZERO
	
	direction.y = -1
	
	if boost_available:
		direction *= boost_speed
	else:
		direction *= speed
	velocity = direction
	move_and_slide()
