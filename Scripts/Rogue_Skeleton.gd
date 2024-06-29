class_name Rogue_Skeleton extends Enemy

const spd_base = 80
const score = 20
const atk_spd_base = 1

func _ready():
	life = stats.rogue_hp
	atk_power = stats.rogue_atk
	speed = spd_base
	enemy_score = score
	atk_speed = atk_spd_base
	if is_boss : 
		life *= 10
		atk_power *= 5
		speed *= 0.8
		enemy_score = 1000
	super()
