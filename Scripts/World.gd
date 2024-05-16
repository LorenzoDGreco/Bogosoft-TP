class_name Mundo extends Node

const offset_coin = 15

var normal_skeleton : PackedScene = preload("res://Scenes/Normal_Skeleton.tscn")
var warrior_skeleton : PackedScene = preload("res://Scenes/Esqueleto_Guerrero.tscn")

var coin : PackedScene = preload("res://Scenes/Coin.tscn")

@onready var hp_bar_ui = get_node("CanvasLayer/CastleUI/HpBarUI")
@onready var Mouse = get_node("Mouse")

var total_coins : int

func _ready():
	hp_bar_ui.set_max_life(100)
	

#posibilidad spawn del 30% de la oleada
func _on_timer_timeout():
	var n_s = normal_skeleton.instantiate()
	n_s.global_position = Vector2(-10, randf_range(55,180))
	n_s.life = 2
	n_s.connect("enemy_death", spawn_coins)
	add_child(n_s)
	
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
	total_coins += coins
	$CanvasLayer/CastleUI/CoinsUI/Label.text = str(total_coins)

func spawn_coins(position, amount):
	position.y += offset_coin
	
	for i in range(0, amount):
		#value_coin randf_range(1,2) Para spawnear monedas de plata u oro 
		var coin_instance =  coin.instantiate()
		coin_instance.connect("coin_pickUp", _on_coin_pick_up)
		coin_instance.value = 10
		coin_instance.global_position = position
		add_child(coin_instance)


func _on_hp_bar_ui_collapsed_castle():
	print("You lose.")
