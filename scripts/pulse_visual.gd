extends Node2D

var radius: float = 0.0
var max_radius: float = 0.0
var color: Color

func start(r: float, c: Color):
	max_radius = r
	color = c
	var tween = create_tween()
	tween.tween_property(self, "radius", max_radius, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_callback(queue_free)

func _process(_delta):
	queue_redraw()

func _draw():
	draw_arc(Vector2.ZERO, radius, 0, TAU, 32, color, 4.0)
	draw_circle(Vector2.ZERO, radius, Color(color, 0.1))
