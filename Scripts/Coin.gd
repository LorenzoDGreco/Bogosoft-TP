extends Area2D

signal coin_pickUp
var value: int

func _on_mouse_exited():
	on_coin_pickUp()

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		on_coin_pickUp()

func on_coin_pickUp():
	coin_pickUp.emit(value)
	queue_free()
