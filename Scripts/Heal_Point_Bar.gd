extends Node2D

const hp_bar_size = 24
var life : float
var max_life : float

func set_life(life_parm):
	if (life == 0):
		max_life = life_parm
	life = life_parm
	
	$TextureRect/Life.text = str(life)
	 
	var percent_bar = hp_bar_size * (life / max_life)
	$TextureRect/PercentLife.set_size(Vector2(percent_bar, 6))
