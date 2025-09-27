class_name ProceduralRoad extends Node3D

@export var length: float = 500.0
@export var width: float = 8.0
@export var max_angle_deviation: float = 45.0
@export var segment_range: Vector2 = Vector2(10.0, 40.0)

var generated_path: Path3D
var generated_csg: CSGPolygon3D

@onready var shape: CSGPolygon3D = %Shape

## Procedural  road generator using SurfaceTool
func generate() -> void:
	var curve: Curve3D = Curve3D.new()
	curve.add_point(Vector3.ZERO)
	
	var distance_traveled: float = 0.0
	var direction: Vector2 = -Vector2.RIGHT
	var last_point: Vector3 = Vector3.ZERO
	var index: int = 0
	
	while distance_traveled < length:
		# Pick a segment length
		var s_length := randf_range(segment_range.x, segment_range.y)
		#if distance_traveled + s_length > length:
			#s_length = length - distance_traveled
		
		# Pick a direction
		var angle: float = 0.0 ## Degrees
		if index > 0:
			angle = MathUtils.randf_range_signed(0.0, max_angle_deviation)
		direction = direction.rotated(deg_to_rad(angle))
		
		var point: Vector3 = Vector3(
			last_point.x + (direction.y * s_length),
			last_point.y,
			last_point.z + (direction.x * s_length),
		)
		
		curve.add_point(point)
		last_point = point
		index += 1
		distance_traveled += s_length
	
	var path: Path3D = Path3D.new()
	path.curve = curve
	
	if generated_path:
		generated_path.free()
	generated_path = path
	add_child(generated_path)
	
	shape.polygon = generate_road_polygon(width)
	shape.path_node = shape.get_path_to(generated_path)
		
	print("Successful regeneration.")


func generate_road_polygon(road_width: float) -> PackedVector2Array:
	var array: PackedVector2Array = [
		Vector2(-1.0 * road_width, 0.0),
		Vector2(-0.6 * road_width, 0.1),
		Vector2(0.6 * road_width, 0.1),
		Vector2(1.0 * road_width, 0.0)
		]
	
	return array
