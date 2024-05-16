extends TextureRect

@onready var life_bar : Label
@onready var percent_life : Panel

const hp_bar_size_width = 24
const hp_bar_size_heigh = 6
var life : float
var max_life : float

func set_life(life_parm):
	if (life == 0):
		max_life = life_parm
		life_bar = $Life
		percent_life = $PercentLife
	life = life_parm
	
	life_bar.text = str(life)
	 
	var percent_bar = hp_bar_size_width * (life / max_life)
	percent_life.set_size(Vector2(percent_bar, hp_bar_size_heigh))
