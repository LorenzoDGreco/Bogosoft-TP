class_name Enemy extends Area2D

var stats : Stats

# Enemy stats
var speed:int
var life:int
var atk_power:int
var atk_speed:int = 3

var hp_bar : PackedScene  = load("res://Scenes/Heal_Point_Bar.tscn")
var hp_bar_instance = hp_bar.instantiate()

var atk_timer = Timer.new()

# Signals sent back to World
signal enemy_death
signal enemy_attack

func _ready():
	add_to_group("enemy")
	set_monitorable(true)
	
	# Enemy HP Bar setup
	hp_bar_instance.position = Vector2(0, -25)
	hp_bar_instance.set_life(life)
	add_child(hp_bar_instance)
	hp_bar_instance.visible = false
	
	# Attack Timer setup
	add_child(atk_timer)
	atk_timer.timeout.connect(attack_castle.bind())

func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	if body.name == "TileMap":
		if life <= 0:
			get_node("AnimatedSprite2D").play("death")
		else:
			# In front of castle, change to idle stance
			speed = 0
			get_node("AnimatedSprite2D").play("default")
			# Attack once, then automate with timer
			attack_castle()
			atk_timer.start(atk_speed)
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
			atk_timer.queue_free()
			position.y -= 8
			speed = 0
		else:
			hp_bar_instance.set_life(life)

func _on_animated_sprite_2d_animation_finished():
	enemy_death.emit(global_position, 1)
	queue_free()

func attack_castle():
	# Show a little hit particle on the castle
	enemy_attack.emit(atk_power)
