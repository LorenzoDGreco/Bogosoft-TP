class_name Arrow extends Area2D

var viewport_size = DisplayServer.window_get_size()
var position_target : Vector2
var direction : Vector2
var stats : Stats
var hit : bool = false

func _ready():
	direction = global_position.direction_to(position_target)
	rotation = direction.angle()

func _process(delta):
	global_position += direction * 300 * delta
	if position.x < 0 or position.x > viewport_size.x or position.y < 0 or position.y > viewport_size.y:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy") and !hit:
		area.recibe_damage(stats.arrow_damage_stat)
		hit = true
		queue_free()
