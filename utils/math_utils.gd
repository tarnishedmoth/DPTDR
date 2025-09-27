class_name MathUtils
#region
## This code originally from Artillery Rampage.
## https://github.com/tryfinsigabrt/Artillery-Rampage

## Returns a random sign (-1.0 or 1.0)
static func randf_sgn() -> float:
	return signf(randf() - 0.5)

## Returns a random float in the range [min_value, max_value] and then multiplies it by a random sign (-1.0 or 1.0)
static func randf_range_signed(min_value: float, max_value: float) -> float:
	return randf_range(min_value, max_value) * randf_sgn()

static func get_angle_deg_between_points(a:Vector2, b:Vector2) -> float:
	return absf(rad_to_deg(a.angle_to_point(b)))

static func get_rand_vector2_dir() -> Vector2:
	return Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	
static func semitransparent(color:Color, pct:float = 0.25) -> Color:
	return color * Color(Color.WHITE, pct)
#endregion


## Used for framerate-independent interpolation smoothing. Feed this value to
## [param weight] in [method @GlobalScope.lerp]. Or use [method delta_lerp].
static func delta_weight(responsiveness:float, deltaTime:float) -> float:
	return 1.0 - exp(-responsiveness * deltaTime)

## Used for framerate-independent interpolation smoothing.
static func delta_lerp(a: float, b: float, factor: float, deltaTime: float):
	return lerp(a, b, delta_weight(factor, deltaTime))

## Alias for [method delta_lerp].
static func dlerp(a: float, b: float, factor: float, deltaTime: float):
	return delta_lerp(a, b, factor, deltaTime)
