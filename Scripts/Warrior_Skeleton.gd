class_name Warrior_Skeleton extends Enemy

const hp_base = 8
const atk_base = 2
const spd_base = 25
const score = 25

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
