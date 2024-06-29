class_name Rogue_Skeleton extends Enemy

const hp_base = 4
const atk_base = 1
const spd_base = 80
const score = 20
const atk_spd_base = 1

func _ready():
	life = hp_base
	atk_power = atk_base
	speed = spd_base
	enemy_score = score
	atk_speed = atk_spd_base
	if is_boss : 
		life *= 3
		atk_power *= 3
		speed *= 0.8
		enemy_score = 1000
	super()
