class_name Mague_Skeleton extends Enemy

var fireball:PackedScene = preload("res://Scenes/Fireball.tscn")

const hp_base = 10
const atk_base = 5
const spd_base = 25
const score = 40

func _ready():
	life = hp_base
	atk_power = atk_base
	speed = spd_base
	enemy_score = score
	if is_boss : 
		life *= 3
		atk_power *= 3
		speed *= 0.8
		enemy_score = 1000
	super()



func attack_castle():
	var new_fireball = fireball.instantiate()
	new_fireball.position = position
	new_fireball.position.y = position.y + 25 
	new_fireball.damage = atk_power
	new_fireball.connect("proyectile_hit", fireball_dmg)
	if is_boss : new_fireball.apply_scale(Vector2(1.5, 1.5))
	get_parent().add_child(new_fireball)


func fireball_dmg(damage):
	enemy_attack.emit(damage)
	print("hola")

