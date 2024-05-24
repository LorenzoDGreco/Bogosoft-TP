extends Area2D

var stats : Stats

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.recibe_damage(stats.click_damage)
