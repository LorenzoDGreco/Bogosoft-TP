class_name Enemy extends Area2D

var stats : Stats

# Enemy stats
var speed:int
var life:int
var atk_power:int
var atk_speed:int = 3
var enemy_score:int
var is_boss : bool = false

var hp_bar : PackedScene  = load("res://Scenes/Heal_Point_Bar.tscn")
var hp_bar_instance = hp_bar.instantiate()

var attack_fx:PackedScene = load("res://Scenes/Enemy_Hit_FX.tscn")
var atk_timer = Timer.new()
var rotate_tween = null

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
	atk_timer.connect("timeout", attack_castle)

func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	if body.name == "TileMap":
		if life <= 0:
			get_node("AnimatedSprite2D").play("death")
		else:
			# In front of castle, change to idle stance
			speed = 0
			position.x += 10
			get_node("AnimatedSprite2D").play("default")
			# Attack once, then automate with timer
			attack_castle()
			atk_timer.start(atk_speed)

func recibe_damage(damage:int):
	if life <= 0:
		if get_node("AnimatedSprite2D").get_animation() == "default":
			_on_animated_sprite_2d_animation_finished()
		return
	
	# Decrease HP, show HP bar and update its value
	hp_bar_instance.visible = true
	life -= damage
	hp_bar_instance.set_life(life)
	
	# Color modulation tween
	var color_tween = get_tree().create_tween()
	color_tween.tween_property(get_node("AnimatedSprite2D"), "modulate", Color.RED, 0.1)
	color_tween.tween_property(get_node("AnimatedSprite2D"), "modulate", Color.WHITE, 0.5)
	
	# On enemy defeat, stop movement, change animations, and free nodes
	if life <= 0:
		atk_timer.queue_free()
		if rotate_tween: rotate_tween.stop()
		get_node("AnimatedSprite2D").set_rotation_degrees(0)
		get_node("AnimatedSprite2D").play("death")
		get_node("CollisionShape2D").queue_free()
		get_node("AnimatedSprite2D/Manos").queue_free()
		hp_bar_instance.queue_free()
		position.y -= 8
		speed = 0

func _on_animated_sprite_2d_animation_changed():
	if self.get_node("AnimatedSprite2D").get_animation() == "death":
		stats.score += enemy_score

func _on_animated_sprite_2d_animation_finished():
	if is_boss: enemy_death.emit(global_position, 5)
	else: enemy_death.emit(global_position, 1)
	queue_free()

func attack_castle():
	# Create a single attack motion, and show a hit particle on the castle
	animate_attack()
	# Signal to World to decrease HP
	enemy_attack.emit(atk_power)
	
func animate_attack():
	# Movement tween
	rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property(self.get_node("AnimatedSprite2D"), "rotation_degrees", 45, 0.1)
	rotate_tween.tween_property(self.get_node("AnimatedSprite2D"), "rotation_degrees", 0, atk_speed - 0.1)
	
	# Instance an attack effect
	var new_attack_fx = attack_fx.instantiate()
	new_attack_fx.connect("animation_finished", new_attack_fx.queue_free)
	new_attack_fx.global_position = Vector2(randi_range(310,316), self.position.y -5)
	get_parent().add_child(new_attack_fx)
