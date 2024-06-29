class_name Fireball extends Area2D

var viewport_size = DisplayServer.window_get_size()
var damage 
var proyectile_speed = 200

signal proyectile_hit

func _process(delta):
	position.x += proyectile_speed * delta
	if position.x < 0 or position.x > viewport_size.x or position.y < 0 or position.y > viewport_size.y:
		queue_free()

func _on_body_entered(body):
	if body.name == "TileMap": 
		proyectile_speed = 0
		proyectile_hit.emit(damage)
		$AnimatedSprite2D.play("explotion")
		$AnimatedSprite2D.apply_scale(Vector2(1.5, 1.5))

func _on_animated_sprite_2d_animation_finished():
	queue_free()
