extends Control

@export var shape_type: int = 0 # 0: HEXAGON, 1: TRIANGLE, 2: SQUARE, 3: CIRCLE
@export var color: Color = Color.WHITE
@export var draw_border: bool = true

func _draw():
	var radius = min(size.x, size.y) / 2.0 * 0.8
	var center = size / 2.0
	
	match shape_type:
		0: # HEXAGON
			draw_polygon(get_poly_points(6, radius, center), [color])
			if draw_border: draw_polyline(get_poly_points(6, radius, center, true), Color.WHITE, 2.0)
		1: # TRIANGLE
			draw_polygon(get_poly_points(3, radius, center), [color])
			if draw_border: draw_polyline(get_poly_points(3, radius, center, true), Color.WHITE, 2.0)
		2: # SQUARE
			var r = radius * 0.8
			draw_rect(Rect2(center.x - r, center.y - r, r*2, r*2), color)
			if draw_border: draw_rect(Rect2(center.x - r, center.y - r, r*2, r*2), Color.WHITE, false, 2.0)
		3: # CIRCLE
			draw_circle(center, radius, color)
			if draw_border: draw_arc(center, radius, 0, TAU, 32, Color.WHITE, 2.0)

func get_poly_points(sides: int, radius: float, center: Vector2, closed: bool = false) -> PackedVector2Array:
	var points = PackedVector2Array()
	for i in range(sides):
		var angle = deg_to_rad(i * 360.0 / sides - 90.0)
		points.push_back(center + Vector2(cos(angle), sin(angle)) * radius)
	if closed:
		points.push_back(points[0])
	return points
