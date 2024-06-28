class_name Normal_Skeleton extends Enemy

const hp_base = 2
const atk_base = 1
const spd_base = 40
const score = 10

func _ready():
	life = hp_base
	atk_power = atk_base
	speed = spd_base
	enemy_score = score
	super()
