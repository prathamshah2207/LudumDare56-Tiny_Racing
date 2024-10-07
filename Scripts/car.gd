extends RigidBody2D

# Speed Variables
@export var base_speed := 100.0  # Normal driving speed
@export var turn_speed := 3.0    # Turning speed

# Current speed (will vary between base and boost speed)
var speed := 250.0

func _ready():
	position = Vector2(-312, 142)

func _physics_process(delta):
	# Reset velocity before applying new one
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

	# Apply velocity to move forward or backward
	if Input.is_action_pressed("move_up"):
		# Forward velocity, using the car's facing direction
		linear_velocity += Vector2(0, -speed).rotated(rotation)
	elif Input.is_action_pressed("move_down"):
		# Backward velocity, using half the speed for reverse
		linear_velocity += Vector2(0, speed).rotated(rotation)

	# Rotate the car
	if Input.is_action_pressed("move_left"):
		angular_velocity += -turn_speed
	if Input.is_action_pressed("move_right"):
		angular_velocity += turn_speed
	# Remove or comment out any code that modifies the camera rotation
	# This ensures the camera remains fixed and does not rotate with the car

	# For example, remove or comment out:
	# $Camera2D.rotation = last_camera_rotation
	# Or any other lines that set $Camera2D.rotation
