class_name Archer extends Node2D

var arrow:PackedScene = preload("res://Scenes/Arrow.tscn")
var stats: Stats

func _ready():
	add_to_group("archer")
	$Timer.wait_time = stats.arrow_cooldown_stat

func _on_timer_timeout():
	$Timer.wait_time = stats.arrow_cooldown_stat

	var enemigos = get_tree().get_nodes_in_group("enemy")
	
	if enemigos.size() > 0:
		# To shoot multiple arrows at once
		for i in stats.number_arrows_stat:
			var enemigo_aleatorio = enemigos[randi() % enemigos.size()]
			disparar(enemigo_aleatorio)
		

func disparar(enemigo):
	if is_instance_valid(enemigo) and enemigo.position.x >= 0:
		var pos_enemigo = enemigo.global_position
		var new_arrow = arrow.instantiate()
		new_arrow.position_target = pos_enemigo
		new_arrow.position = position
		new_arrow.stats = stats
		get_parent().add_child(new_arrow)
