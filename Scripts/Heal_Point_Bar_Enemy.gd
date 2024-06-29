extends TextureRect

@onready var life_bar: Label
@onready var percent_life: Sprite2D

var life: float = 0
var max_life: float = 100
var initial_position: Vector2
var initial_width: float
var initial_scale: float

var suffixes = ["", "K", "M", "B", "T", "Q", "Qt"]  # Add more suffixes as needed

func _ready():
	# Guardar la posición inicial de la barra de vida, el ancho de la textura y la escala inicial
	initial_position = percent_life.position
	initial_width = percent_life.texture.get_width()
	initial_scale = percent_life.scale.x
	set_life(max_life)  # Inicializamos la barra de vida a su valor máximo al principio

func set_life(life_parm: float):
	if life == 0:
		max_life = life_parm
		life_bar = $Life
		percent_life = $PercentLife
		initial_position = percent_life.position
		initial_width = percent_life.texture.get_width()
		initial_scale = percent_life.scale.x
	
	life = life_parm
	
	life_bar.text = format_number(life)

	# Proporción de vida restante
	var life_ratio = life / max_life

	# Ajustar la escala del Sprite2D en el eje x
	percent_life.scale.x = life_ratio * initial_scale

	# Ajustar la posición del Sprite2D para que se reduzca de derecha a izquierda
	percent_life.position.x = initial_position.x - (initial_width * initial_scale * (1 - life_ratio)) * 0.5

func format_number(number):
	var formatted_number = float(number)
	var suffix_index = 0
	
	while formatted_number >= 1000.0 and suffix_index < suffixes.size() - 1:
		formatted_number /= 1000
		suffix_index += 1
	
	if suffix_index == 0 and number == int(number): 
		return str(number)
	return (("%.02f" % formatted_number) + suffixes[suffix_index])
