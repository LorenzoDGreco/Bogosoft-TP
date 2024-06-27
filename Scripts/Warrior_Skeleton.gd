class_name Warrior_Skeleton extends Enemy

const hp_base = 8
const atk_base = 2
const spd_base = 25

func _ready():
	life = hp_base
	atk_power = atk_base
	speed = spd_base
	super()
