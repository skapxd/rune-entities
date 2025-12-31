extends Node2D

var parent_entity: RuneEntity

func _process(_delta):
	queue_redraw()

func _draw():
	if not parent_entity: return
	
	var color = parent_entity.get_element_color(parent_entity.element) if parent_entity.element != parent_entity.Element.NONE else parent_entity.base_color
	var health_ratio = parent_entity.current_health / parent_entity.max_health
	var bar_width = 60.0
	var bar_height = 4.0
	var bar_pos = Vector2(-bar_width/2, -50)
	
	# Background
	draw_line(bar_pos, bar_pos + Vector2(bar_width, 0), Color.BLACK, bar_height + 2.0)
	# Health
	draw_line(bar_pos, bar_pos + Vector2(bar_width * health_ratio, 0), color, bar_height)
