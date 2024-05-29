class_name Archer extends Node2D

var arrow:PackedScene = preload("res://Scenes/Arrow.tscn")
var stats: Stats

func _on_timer_timeout():
	var enemigos = get_tree().get_nodes_in_group("enemy")
	
	if enemigos.size() > 0:
		# TODO: ITERAR POR MULTI SHOOT
		var enemigo_aleatorio = enemigos[randi() % enemigos.size()]
		disparar(enemigo_aleatorio)

func disparar(enemigo):
	if is_instance_valid(enemigo):
		var pos_enemigo = enemigo.global_position
		var new_arrow = arrow.instantiate()
		new_arrow.position_target = pos_enemigo
		new_arrow.position = position
		new_arrow.stats = stats
		get_parent().add_child(new_arrow)
