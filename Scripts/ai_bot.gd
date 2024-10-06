extends CharacterBody2D

@export var speed := 400.0
@export var accel := 10.0
@export var boost_speed := 800.0
var boost_available := false
@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	var direction = Vector2()
	nav.target_position = get_global_mouse_position()
	
	direction = nav.get_next_path_position() - global_position
	print(direction.normalized())
	#direction = direction.normalized()
	#velocity = velocity.lerp(direction*speed, accel*delta)
	
	#if boost_available:
		#direction *= boost_speed
	#else:
		#direction *= speed
	#velocity = direction
	move_and_slide()
