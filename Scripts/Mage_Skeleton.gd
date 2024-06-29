class_name Mage_Skeleton extends Enemy

var fireball:PackedScene = preload("res://Scenes/Fireball.tscn")
@onready var hands = $AnimatedSprite2D/Manos

const spd_base = 25
const score = 40

func _ready():
	life = stats.mage_hp
	atk_power = stats.mage_atk
	speed = spd_base
	enemy_score = score
	if is_boss : 
		life *= 10
		atk_power *= 5
		speed *= 0.8
		enemy_score = 1000
	super()

func attack_castle():
	animate_attack()
	
	var new_fireball = fireball.instantiate()
	new_fireball.position = position
	new_fireball.position.y = position.y + 5 
	new_fireball.damage = atk_power
	new_fireball.connect("proyectile_hit", fireball_dmg)
	if is_boss : new_fireball.apply_scale(Vector2(1.5, 1.5))

	# Use call_deferred to add new_fireball as a child
	call_deferred("_add_new_fireball", new_fireball)

func _add_new_fireball(new_fireball):
	# Add new_fireball as a child to the parent node
	get_parent().add_child(new_fireball)

# Corrects the extra steps for regular attacks
func _on_body_entered(body):
	position.x -= 10
	hands.set_flip_v(true)
	super(body)

func fireball_dmg(damage):
	enemy_attack.emit(damage)

func animate_attack():
	# Hand movement tween
	var hands_tween = get_tree().create_tween()
	hands_tween.tween_property(hands, "position", Vector2(hands.position.x, hands.position.y - 15), 0.1)
	hands_tween.tween_property(hands, "position", Vector2(hands.position.x, hands.position.y), atk_speed - 0.1)
