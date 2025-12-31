extends RuneEntity

@export var detection_range: float = 400.0
var player: Node2D

func _ready():
	super._ready()
	# Find player in group
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if not player:
		player = get_tree().get_first_node_in_group("player")
		return
		
	var dist = global_position.distance_to(player.global_position)
	if dist < detection_range:
		var dir = global_position.direction_to(player.global_position)
		velocity = dir * speed
		rotation = lerp_angle(rotation, dir.angle() + PI/2, 0.1)
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
