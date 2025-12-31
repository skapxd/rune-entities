extends CanvasLayer

@onready var health_bar = $MarginContainer/HBoxContainer/VBoxContainer/HealthBar
@onready var mana_bar = $MarginContainer/HBoxContainer/VBoxContainer/ManaBar
@onready var player_logo = $MarginContainer/HBoxContainer/PlayerLogo
@onready var summon_icon_1 = $MarginContainer/HBoxContainer/VBoxContainer/IconsHBox/Icon1
@onready var summon_icon_2 = $MarginContainer/HBoxContainer/VBoxContainer/IconsHBox/Icon2

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.health_changed.connect(_on_player_health_changed)
		player.mana_changed.connect(_on_player_mana_changed)
		
	setup_styles()

func setup_styles():
	# Crear estilos visuales por código para las barras
	var sb_bg = StyleBoxFlat.new()
	sb_bg.bg_color = Color(0.1, 0.1, 0.1, 0.6)
	sb_bg.set_border_width_all(2)
	sb_bg.border_color = Color(0.3, 0.3, 0.3)
	
	var sb_hp = StyleBoxFlat.new()
	sb_hp.bg_color = Color(0.8, 0.2, 0.2)
	sb_hp.set_border_width_all(2)
	sb_hp.border_color = Color(1, 0.5, 0.5)
	
	var sb_mp = StyleBoxFlat.new()
	sb_mp.bg_color = Color(0.2, 0.5, 0.9)
	sb_mp.set_border_width_all(2)
	sb_mp.border_color = Color(0.5, 0.8, 1.0)
	
	health_bar.add_theme_stylebox_override("background", sb_bg)
	health_bar.add_theme_stylebox_override("fill", sb_hp)
	
	mana_bar.add_theme_stylebox_override("background", sb_bg)
	mana_bar.add_theme_stylebox_override("fill", sb_mp)

func _on_player_health_changed(current, max_val):
	health_bar.max_value = max_val
	health_bar.value = current

func _on_player_mana_changed(current, max_val):
	mana_bar.max_value = max_val
	mana_bar.value = current
