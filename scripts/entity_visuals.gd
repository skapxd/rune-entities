extends Node2D

var parent_entity: RuneEntity

func _draw():
	if not parent_entity: return
	
	var color = parent_entity.get_element_color(parent_entity.element) if parent_entity.element != parent_entity.Element.NONE else parent_entity.base_color
	var radius = 30.0
	
	match parent_entity.shape_type:
		parent_entity.ShapeType.HEXAGON:
			draw_polygon(parent_entity.get_poly_points(6, radius), [color])
			draw_polyline(parent_entity.get_poly_points(6, radius, true), Color.WHITE, 2.0)
		parent_entity.ShapeType.TRIANGLE:
			draw_polygon(parent_entity.get_poly_points(3, radius), [color])
			draw_polyline(parent_entity.get_poly_points(3, radius, true), Color.WHITE, 2.0)
		parent_entity.ShapeType.SQUARE:
			draw_rect(Rect2(-radius, -radius, radius*2, radius*2), color)
			draw_rect(Rect2(-radius, -radius, radius*2, radius*2), Color.WHITE, false, 2.0)
		parent_entity.ShapeType.CIRCLE:
			draw_circle(Vector2.ZERO, radius, color)
			draw_arc(Vector2.ZERO, radius, 0, TAU, 32, Color.WHITE, 2.0)
