class_name Player extends Node3D

@export var top_speed: float = 5.0
@export var responsiveness:float = 0.8

#const DEADZONE:float = TAU * 0.15

var heading:float = 0.0
var current_speed:float = 0.0

func _process(delta: float) -> void:
	## Accel / Decel
	if not Input.is_action_pressed(&"Brake"):
		if Input.is_action_pressed(&"Accelerate"):
			current_speed = dlerp(current_speed, top_speed / 10.0, responsiveness , delta)
		else:
			current_speed = dlerp(current_speed, 0.0, responsiveness * 0.6, delta)
	
	else:
		# Brake overrides acceleration
		current_speed = dlerp(current_speed, 0.0, responsiveness, delta)
		
	## Steering
	var angle: float
	var input_direction: Vector2 = Input.get_vector(&"Left", &"Right", &"Down", &"Up")
	if input_direction.length() != 0:
		heading = input_direction.angle()
		rotation.y = heading
		#angle = input_direction.angle() / (PI/4)
		#angle = wrapi(int(angle), 0, 8)
		#print(angle)
	
	position += -basis.z * current_speed

func dlerp(a: float, b: float, factor: float, deltaTime: float):
	return MathUtils.dlerp(a, b, factor, deltaTime)
