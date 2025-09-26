class_name Player extends Node3D

@export var top_speed: float = 5.0
@export var unresponsiveness:float = 0.6

#const DEADZONE:float = TAU * 0.15

var heading:float = 0.0
var current_speed:float = 0.0

func _process(delta: float) -> void:
	## Accel / Decel
	if not Input.is_action_pressed(&"Brake"):
		if Input.is_action_pressed(&"Accelerate"):
			current_speed = delta_lerp(current_speed, top_speed / 10.0, unresponsiveness * 0.5, delta)
		else:
			current_speed = delta_lerp(current_speed, 0.0, unresponsiveness, delta)
	
	else:
		# Brake overrides acceleration
		current_speed = delta_lerp(current_speed, 0.0, unresponsiveness * 0.15, delta)
		
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

func delta_lerp(a: float, b: float, factor: float, deltaTime: float):
	## FIXME THIS IS WRONGGGGG should not be using delta time in lerp
	return lerp(a, b, 1 - (factor ** deltaTime))
