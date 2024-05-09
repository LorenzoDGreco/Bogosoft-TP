class_name Enemy extends Area2D
#
var speed:int = 50
#var x_spawn = -100
var screensize = DisplayServer.window_get_size()
#
#var enemy_scene_path:String = "res://Scenes/Esqueleto_Normal.tscn"
#
func _ready():
	get_node("AnimatedSprite2D").play("default")
	#var enemy_instance = load(enemy_scene_path).instance()
	#add_child(enemy_instance)
	#enemy_instance.position.x = x_spawn
	#enemy_instance.position.y = choose_y_spawn()
#
func _process(delta):
	
	position.x += speed * delta
	if (position.x > screensize.x):
		queue_free()
#
#func choose_y_spawn():
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#return int(rng.randi_range(0, screensize.y))


func _on_area_entered(area):
	pass # Replace with function body.
