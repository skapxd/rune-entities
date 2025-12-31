extends Node2D

func start(shape_type: int, color: Color, radius: float, points: PackedVector2Array):
	for i in range(8): # Creamos 8 fragmentos
		var fragment = Polygon2D.new()
		add_child(fragment)
		
		# Crear un mini-triángulo/fragmento aleatorio
		var f_size = radius * randf_range(0.2, 0.4)
		var f_points = PackedVector2Array([
			Vector2.ZERO,
			Vector2(randf_range(-f_size, f_size), randf_range(-f_size, f_size)),
			Vector2(randf_range(-f_size, f_size), randf_range(-f_size, f_size))
		])
		
		fragment.polygon = f_points
		fragment.color = color
		
		# Animación de explosión
		var target_pos = Vector2(randf_range(-100, 100), randf_range(-100, 100))
		var tween = create_tween().set_parallel(true)
		tween.tween_property(fragment, "position", target_pos, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(fragment, "rotation", randf_range(-PI, PI), 0.5)
		tween.tween_property(fragment, "modulate:a", 0.0, 0.5)
		
	# Limpiar el nodo después de la animación
	get_tree().create_timer(0.6).timeout.connect(queue_free)