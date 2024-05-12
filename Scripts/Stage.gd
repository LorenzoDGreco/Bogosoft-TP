class_name Mundo extends Node

const offset_coin = 15

var normal_skeleton : PackedScene = preload("res://Scenes/Normal_Skeleton.tscn")
var coin : PackedScene = preload("res://Scenes/Coin.tscn")

#posibilidad spawn del 30% de la oleada
func _on_timer_timeout():
	var n_s = normal_skeleton.instantiate()
	n_s.global_position = Vector2(-10, randf_range(20,200))
	n_s.life = 1
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
	print(coins)

func spawn_coins(position, amount):
	position.y += offset_coin
	
	for i in range(0, amount):
		#value_coin randf_range(1,2) Para spawnear monedas de plata u oro 
		var coin_intance =  coin.instantiate()
		coin_intance.connect("coin_pickUp", _on_coin_pick_up)
		coin_intance.value = 10
		coin_intance.global_position = position
		add_child(coin_intance)
	
