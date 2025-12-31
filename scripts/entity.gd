extends CharacterBody2D
class_name RuneEntity

enum Element { FIRE, WATER, WIND, EARTH, LIGHT, DARK, NONE }
enum ShapeType { HEXAGON, TRIANGLE, SQUARE, CIRCLE }

@export var entity_name: String = "Entity"
@export var element: Element = Element.NONE
@export var shape_type: ShapeType = ShapeType.TRIANGLE
@export var base_color: Color = Color.WHITE
@export var max_health: float = 100.0
@export var speed: float = 200.0

var current_health: float

@onready var visual_node = Node2D.new()
@onready var ui_node = Node2D.new()

func _ready():
	current_health = max_health
	
	# Setup visual node (this one will rotate)
	add_child(visual_node)
	visual_node.set_script(load("res://scripts/entity_visuals.gd"))
	visual_node.parent_entity = self
	
	# Setup UI node (this one stays upright)
	add_child(ui_node)
	ui_node.set_script(load("res://scripts/entity_ui.gd"))
	ui_node.parent_entity = self

func _process(_delta):
	# The main entity handles movement/rotation logic
	# But we make sure UI stays at rotation 0 relative to world
	ui_node.global_rotation = 0.0

func take_damage(amount: float, attacker_element: Element = Element.NONE):
	var multiplier = get_element_multiplier(attacker_element, element)
	current_health -= amount * multiplier
	
	# Visual feedback for damage on the visual node
	var tween = create_tween()
	tween.tween_property(visual_node, "modulate", Color.WHITE * 5.0, 0.1)
	tween.tween_property(visual_node, "modulate", Color.WHITE, 0.1)
	
	if current_health <= 0:
		die()

func get_poly_points(sides: int, radius: float, closed: bool = false) -> PackedVector2Array:
	var points = PackedVector2Array()
	for i in range(sides):
		var angle = deg_to_rad(i * 360.0 / sides - 90.0)
		points.push_back(Vector2(cos(angle), sin(angle)) * radius)
	if closed:
		points.push_back(points[0])
	return points

func get_element_multiplier(atk: Element, def: Element) -> float:
	match [atk, def]:
		[Element.FIRE, Element.WIND]: return 1.5
		[Element.WATER, Element.FIRE]: return 1.5
		[Element.WIND, Element.EARTH]: return 1.5
		[Element.EARTH, Element.WATER]: return 1.5
		[Element.LIGHT, Element.DARK]: return 2.0
		[Element.DARK, Element.LIGHT]: return 2.0
	return 1.0

func die():
	queue_free()

func get_element_color(type: Element) -> Color:
	match type:
		Element.FIRE: return Color(1.0, 0.2, 0.2)
		Element.WATER: return Color(0.2, 0.5, 1.0)
		Element.WIND: return Color(0.4, 1.0, 0.4)
		Element.EARTH: return Color(0.7, 0.4, 0.2)
		Element.LIGHT: return Color(1.0, 1.0, 0.8)
		Element.DARK: return Color(0.5, 0.1, 0.8)
	return Color.WHITE