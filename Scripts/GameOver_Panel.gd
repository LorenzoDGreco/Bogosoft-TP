extends Node

var stats:Stats

# Text element
@onready var game_over_label = $MarginContainer/HBoxContainer/VBoxContainer/Label

# Results Labels
@onready var click_damage_label = $MarginContainer/HBoxContainer/GridContainer/ClickDamage/Label
@onready var click_area_size_label = $MarginContainer/HBoxContainer/GridContainer/ClickAreaSize/Label
@onready var click_area_damage_label = $MarginContainer/HBoxContainer/GridContainer/ClickAreaDamage/Label
@onready var castle_max_hp_label = $MarginContainer/HBoxContainer/GridContainer/CastleMaxHP/Label
@onready var number_archers_label = $MarginContainer/HBoxContainer/GridContainer/NumberArchers/Label
@onready var number_arrows_label = $MarginContainer/HBoxContainer/GridContainer/NumberArrows/Label
@onready var arrow_damage_label = $MarginContainer/HBoxContainer/GridContainer/ArrowDamage/Label
@onready var arrow_cooldown_label = $MarginContainer/HBoxContainer/GridContainer/ArrowCooldown/Label

# Buttons and Signals
var btn_enable_timer = Timer.new()
@onready var restart_button = $MarginContainer/HBoxContainer/VBoxContainer/ClickControls/RestartButton
signal restart_game
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/ClickControls/QuitButton
signal quit_game

func _ready():
	# Diasble the buttons initially
	restart_button.set_visible(false)
	quit_button.set_visible(false)
	add_child(btn_enable_timer)
	btn_enable_timer.connect("timeout", activate_buttons)

func load_values():
	click_damage_label.text = "LV." + str(stats.click_damage_level)
	click_area_size_label.text = "LV." + str(stats.click_area_size_level)
	click_area_damage_label.text = "LV." + str(stats.click_area_damage_level)
	castle_max_hp_label.text = "LV." + str(stats.castle_max_hp_level)
	number_archers_label.text = "LV." + str(stats.number_archers_level)
	number_arrows_label.text = "LV." + str(stats.number_arrows_level)
	arrow_damage_label.text = "LV." + str(stats.arrow_damage_level)
	arrow_cooldown_label.text = "LV." + str(stats.arrow_cooldown_level)
	
	#btn_enable_timer.set_one_shot(true)
	btn_enable_timer.start(2)
	
func activate_buttons():
	var game_over_tween = get_tree().create_tween()
	game_over_tween.tween_property(game_over_label, "position", Vector2(0, 56), 0.5)
	game_over_tween.tween_property(restart_button, "visible", true, 0)
	game_over_tween.tween_property(quit_button, "visible", true, 0)

func _on_restart_button_pressed():
	restart_game.emit()
	
func _on_quit_button_pressed():
	quit_game.emit()
