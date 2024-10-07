extends RigidBody2D

# Speed Variables
@export var turn_speed := 3.3    # Turning speed

# Current speed (will vary between base and boost speed)
var speed := 350.0

func _ready():
	pass

func _physics_process(delta):
	# Reset velocity before applying new one

	var is_moving = false
	var reverse = false

	# Apply velocity to move forward or backward
	if Input.is_action_pressed("move_up"):
		is_moving = true
		# Forward velocity, using the car's facing direction
		linear_velocity = Vector2(0, -speed).rotated(rotation)
		$Sprite2D.play("smoke")
	if Input.is_action_pressed("move_down"):
		# Backward velocity, using half the speed for reverse
		is_moving = true
		reverse = true
		linear_velocity = Vector2(0, speed).rotated(rotation) 
	# Rotate the car only if it is moving
	if is_moving:
		if Input.is_action_pressed("move_left"):
			if reverse:
				angular_velocity = turn_speed
			else:
				angular_velocity = -turn_speed
		if Input.is_action_pressed("move_right"):
			if reverse:
				angular_velocity = -turn_speed
			else:
				angular_velocity = turn_speed
