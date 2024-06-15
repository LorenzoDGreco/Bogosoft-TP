class_name Mundo extends Node

const offset_coin = 15

var normal_skeleton : PackedScene = preload("res://Scenes/Normal_Skeleton.tscn")
var warrior_skeleton : PackedScene = preload("res://Scenes/Warrior_Skeleton.tscn")
var mouse : PackedScene = preload("res://Scenes/Mouse.tscn")
var coin : PackedScene = preload("res://Scenes/Coin.tscn")

@onready var stats = Stats.new()
@onready var mouse_instance = mouse.instantiate()

@onready var upgrades_panel = $CanvasLayer/UpgradesPanel
@onready var top_panel = $CanvasLayer/TopPanel

func _ready():
	# Initialize Top Panel
	top_panel.stats = stats
	top_panel.load_values()
	
	# Initialize Upgrades Panel (and link to Top Panel for updates)
	upgrades_panel.stats = stats
	upgrades_panel.top_panel = top_panel
	upgrades_panel.load_initial_values()
	
	mouse_instance.stats = stats
	add_child(mouse_instance)

#posibilidad spawn del 30% de la oleada
func _on_timer_timeout():
	var n_s = normal_skeleton.instantiate()
	#n_s.global_position = Vector2(-10, randf_range(55,180))
	n_s.global_position = Vector2(-10, 50)
	n_s.connect("enemy_death", spawn_coins)
	n_s.stats = stats
	get_node("Enemys").add_child(n_s)
	
	var w_s = warrior_skeleton.instantiate()
	#w_s.global_position = Vector2(-10, randf_range(55,180))
	w_s.global_position = Vector2(-10, 175)
	w_s.connect("enemy_death", spawn_coins)
	w_s.stats = stats
	get_node("Enemys").add_child(w_s)
	
	#dificultad = new 
	#dificultad.calcular()
	#if oleada > 1:
		#oleada--
		#random -> 1*3
		#enemy = new
		#enemy.setInicio(vida, asd, asd)
	#elif oleada = 0:
		#boss
	#vida += dificultad
	#daño += dificultad

func _on_coin_pick_up(coins):
	# Updates the internal total_coins stat
	stats.total_coins += coins
	# Updates total coins on display
	top_panel.update_player_coins()
	# Updates every upgrade button state
	upgrades_panel.update_upgrade_button_status()

func spawn_coins(position, _amount):
	
	position.y += offset_coin
	
	#for i in range(0, _amount):
		#value_coin randf_range(1,2) Para spawnear monedas de plata u oro 
	var coin_instance =  coin.instantiate()
	coin_instance.connect("coin_pickUp", _on_coin_pick_up)
	coin_instance.value = stats.coin_value
	coin_instance.global_position = position
	$CanvasLayer.add_child(coin_instance)

#func _on_hp_bar_ui_collapsed_castle():
	#print("You lose.")
