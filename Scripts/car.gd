extends RigidBody2D

# Speed Variables
@export var base_speed := 100.0  # Normal driving speed
@export var turn_speed := 5.0    # Turning speed

# Current speed (will vary between base and boost speed)
var current_speed := 550.0

func _ready():
	pass  # No need to store initial rotation anymore

func _physics_process(delta):
	# Reset velocity before applying new one
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

	# Apply velocity to move forward or backward
	if Input.is_action_pressed("move_up"):
		# Forward velocity, using the car's facing direction
		linear_velocity += Vector2(0, -current_speed).rotated(rotation)
		$Sprite2D.play("run")
	elif Input.is_action_pressed("move_down"):
		# Backward velocity, using half the speed for reverse
		linear_velocity += Vector2(0, current_speed).rotated(rotation)
		$Sprite2D.play("smoke")

	# Rotate the car
	if Input.is_action_pressed("move_left"):
		angular_velocity += -turn_speed
		$Sprite2D.play("fire")
	if Input.is_action_pressed("move_right"):
		angular_velocity += turn_speed
		$Sprite2D.play("fire")

	# Remove or comment out any code that modifies the camera rotation
	# This ensures the camera remains fixed and does not rotate with the car

	# For example, remove or comment out:
	# $Camera2D.rotation = last_camera_rotation
	# Or any other lines that set $Camera2D.rotation
