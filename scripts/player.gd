extends RuneEntity

signal health_changed(current, max_val)
signal mana_changed(current, max_val)

@export var max_mana: float = 100.0
var current_mana: float

func _ready():
	super._ready()
	current_mana = max_mana
	entity_name = "Player"
	shape_type = ShapeType.HEXAGON
	element = Element.NONE 
	base_color = Color(0.2, 0.8, 1.0)
	
	# Emitir valores iniciales
	health_changed.emit(current_health, max_health)
	mana_changed.emit(current_mana, max_mana)

func _process(delta):
	# Regeneración pasiva de maná
	if current_mana < max_mana:
		current_mana = min(max_mana, current_mana + 5.0 * delta)
		mana_changed.emit(current_mana, max_mana)

func take_damage(amount: float, attacker_element: Element = Element.NONE):
	super.take_damage(amount, attacker_element)
	health_changed.emit(current_health, max_health)

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2.ZERO:
		rotation = lerp_angle(rotation, direction.angle() + PI/2, 0.2)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		perform_attack()

func perform_attack():
	# Ataque de pulso radial
	var attack_range = 150.0
	var damage = 25.0
	
	# Visualización del ataque
	var pulse = Node2D.new()
	get_parent().add_child(pulse)
	pulse.global_position = global_position
	pulse.set_script(load("res://scripts/pulse_visual.gd"))
	pulse.start(attack_range, base_color)
	
	# Lógica de daño
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) <= attack_range:
			if enemy.has_method("take_damage"):
				enemy.take_damage(damage, element)
