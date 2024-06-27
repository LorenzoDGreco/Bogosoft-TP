extends Area2D

var stats : Stats
var hit : bool = false

func _on_area_entered(area):
	if area.is_in_group("enemy") && !hit:
		area.recibe_damage(stats.click_damage_stat)
		hit = true

func _on_timer_timeout():
	hit = true

func _on_click_fx_animation_finished():
	queue_free()
