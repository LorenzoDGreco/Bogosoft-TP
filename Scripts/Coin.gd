class_name Coin extends Area2D

signal coin_pickUp
var value

func _ready():
	add_to_group("coin")
	set_monitorable(false)

func _on_mouse_exited():
	on_coin_pickUp()

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		on_coin_pickUp()

func _on_timer_timeout():
	on_coin_pickUp()

func on_coin_pickUp():
	var move_coin = get_tree().create_tween()
	move_coin.tween_property(self, "position", Vector2(112, 12), 0.5)
	move_coin.connect("finished", on_move_coin_finished)
	
func on_move_coin_finished():
	coin_pickUp.emit(value)
	queue_free()
