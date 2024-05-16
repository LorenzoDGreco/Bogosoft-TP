class_name HpBarUI extends TextureRect

const hp_bar_size_width = 69
const hp_bar_size_heigh = 8
var life : float
var max_life : float

signal collapsed_castle

func set_max_life(life_upgrade):
	if max_life < life_upgrade:
		max_life = life_upgrade
		life = life_upgrade #Si se mejora la vida me curo todo
		$Hp_Castle.text = str(life) + " / " + str(max_life)

func damage_received(life_parm):
	life -= life_parm
	 
	var percent_bar = hp_bar_size_width * (life / max_life)
	$HpBar.set_size(Vector2(percent_bar, hp_bar_size_heigh))
	
	$Hp_Castle.text = str(life) + " / " + str(max_life)
	
	if life <= 0:
		collapsed_castle.emit()
