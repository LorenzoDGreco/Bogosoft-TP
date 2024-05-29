class_name Enemy extends Area2D

var screensize = DisplayServer.window_get_size()
var stats : Stats
var speed:int = 50
var life:int

var hp_bar : PackedScene  = load("res://Scenes/Heal_Point_Bar.tscn")
var hp_bar_instance = hp_bar.instantiate()

signal enemy_death

func _ready():
	add_to_group("enemy")
	set_monitorable(true)
	
	hp_bar_instance.position = Vector2(0, 13)
	hp_bar_instance.set_life(life)
	add_child(hp_bar_instance)
	hp_bar_instance.visible = false

func _process(delta):
	position.x += speed * delta
	if (position.x > screensize.x):
		queue_free()

func _on_body_entered(body):
	if body.name == "TileMap":
		get_node("AnimatedSprite2D").play("default")
		speed=0
		#set_deferred("monitorable", false) #Soluciona el lag en gran medida (100 enemigos up) pero cuidado con las hitbox de las flechas

func recibe_damage(damage:int):
	if life <= 0:
		if get_node("AnimatedSprite2D").get_animation() == "default":
			_on_animated_sprite_2d_animation_finished()
		return
	
	if life > 0:
		hp_bar_instance.visible = true
		life -= damage 
		
		if life <= 0:
			get_node("AnimatedSprite2D").play("death")
			get_node("CollisionShape2D").queue_free()
			get_node("Manos").queue_free()
			hp_bar_instance.queue_free()
			position.y -= 8
			speed = 0
		else:
			hp_bar_instance.set_life(life)

func _on_animated_sprite_2d_animation_finished():
	enemy_death.emit(global_position, 1)
	queue_free()
