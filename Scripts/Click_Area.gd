extends Area2D

var stats : Stats

func _ready():
	$CollisionShape2D.shape.set("radius", stats.area_click)

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.recibe_damage(stats.area_damage)
