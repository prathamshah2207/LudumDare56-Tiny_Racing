extends RigidBody2D

# Speed Variables
@export var base_speed := 100.0  # Normal driving speed
@export var turn_speed := 5.0  # Turning speed

# Current speed (will vary between base and boost speed)
var current_speed := 550.0

func _ready():
	pass

func _physics_process(delta):
	# Reset velocity before applying new one
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

	# Apply velocity to move forward or backward
	if Input.is_action_pressed("move_up"):
		# Forward velocity, using the car's facing direction
		linear_velocity += Vector2(0, -current_speed).rotated(rotation)
	elif Input.is_action_pressed("move_down"):
		# Backward velocity, using half the speed for reverse
		linear_velocity += Vector2(0, current_speed).rotated(rotation)

	# Rotate the car
	if Input.is_action_pressed("move_left"):
		angular_velocity += -turn_speed 
	if Input.is_action_pressed("move_right"):
		angular_velocity += turn_speed
