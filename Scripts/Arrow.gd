class_name Arrow extends Area2D

const x_start:int = 344
const y_start:int = 24
var direction:Vector2
var stats:Stats
var arrow_shot:bool = false

func _ready():
	set_monitorable(false)

func _process(delta):
	if (arrow_shot):
		#global_position.x -= direction.x * delta * 100
		#global_position.y += direction.y * delta * 100
		global_position += direction * 100 * delta
		#position.y = -position.y
		#position.x += -54*delta*stats.archer_speed
		#position.y += 30*delta*stats.archer_speed

func shoot_target(target):
	position.x = x_start
	position.y = y_start
	
	#361, 16
	#direction = Vector2(300 - global_position.x, -200 - global_position.y).normalized()
	#direction = Vector2(target.position)
	#print(str(direction) + " + " + str(target.position))
	
	# TODO: arreglar detección de targets ya muertos
	direction = global_position.direction_to(target.global_position)
	rotation = direction.angle()
	#print(str(position.x) + " + " + str(position.y))
	arrow_shot = true


func _on_body_entered(body):
	print(body.name)
	if body.name != "TileMap" and body.name != "Coin":
		queue_free()
