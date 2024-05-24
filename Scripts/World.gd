class_name Mundo extends Node

const offset_coin = 15

var normal_skeleton : PackedScene = preload("res://Scenes/Normal_Skeleton.tscn")
var warrior_skeleton : PackedScene = preload("res://Scenes/Warrior_Skeleton.tscn")
var mouse : PackedScene = preload("res://Scenes/Mouse.tscn")
var coin : PackedScene = preload("res://Scenes/Coin.tscn")

@onready var upgrades = Upgrades.new()
@onready var stats = Stats.new()
@onready var upgrades_menu = get_node("CanvasLayer/Upgrades")
@onready var hp_bar_ui = get_node("CanvasLayer/CastleUI/HpBarUI")
@onready var mouse_instance = mouse.instantiate()

func _ready():
	hp_bar_ui.set_max_life(stats.max_life)
	
	upgrades_menu.upgrades = upgrades
	upgrades_menu.stats = stats
	
	mouse_instance.stats = stats
	add_child(mouse_instance)

#posibilidad spawn del 30% de la oleada
func _on_timer_timeout():
	var n_s = normal_skeleton.instantiate()
	n_s.global_position = Vector2(-10, randf_range(55,180))
	n_s.connect("enemy_death", spawn_coins)
	n_s.stats = stats
	get_node("Enemys").add_child(n_s)
	
	var w_s = warrior_skeleton.instantiate()
	w_s.global_position = Vector2(-10, randf_range(55,180))
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
	stats.total_coins += coins
	$CanvasLayer/CastleUI/CoinsUI/Label.text = str(stats.total_coins)

func spawn_coins(position, _amount):
	
	position.y += offset_coin
	
	#for i in range(0, _amount):
		#value_coin randf_range(1,2) Para spawnear monedas de plata u oro 
	var coin_instance =  coin.instantiate()
	coin_instance.connect("coin_pickUp", _on_coin_pick_up)
	coin_instance.value = stats.coin_value
	coin_instance.global_position = position
	$CanvasLayer.add_child(coin_instance)

func _on_hp_bar_ui_collapsed_castle():
	print("You lose.")
