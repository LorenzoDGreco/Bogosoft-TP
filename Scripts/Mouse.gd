extends AnimatedSprite2D

var click = preload("res://Scenes/Click_Area.tscn")
var click_instance

var stats : Stats

func _process(_delta):
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), Input.CURSOR_ARROW, Vector2(sprite_frames.get_frame_texture(animation, frame).get_width(), sprite_frames.get_frame_texture(animation, frame).get_height()) / 2)

func _unhandled_input(event):
	if (event is InputEventMouseButton && event.pressed):
		self.play("on_click")
		click_instance = click.instantiate()
		click_instance.stats = stats
		click_instance.global_position = get_global_mouse_position()
		get_parent().add_child(click_instance)
	if (event is InputEventMouseButton && event.is_released()):
		self.play("click")
		click_instance.queue_free()
