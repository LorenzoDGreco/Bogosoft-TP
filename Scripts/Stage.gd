class_name Stage extends Node

#export var enemy_scene : PackedScene
var enemy_scene = preload("res://Scenes/Esqueleto_Normal.tscn")

func _ready():
	pass # Reemplaza con el cuerpo de la función.

func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(-20, randf_range(20,200))
	add_child(enemy)
