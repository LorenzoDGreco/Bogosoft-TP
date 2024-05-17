extends AnimatedSprite2D

func _process(_delta):
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), Input.CURSOR_ARROW, Vector2(sprite_frames.get_frame_texture(animation, frame).get_width(), sprite_frames.get_frame_texture(animation, frame).get_height()) / 2)

func _unhandled_input(event):
	if (event is InputEventMouseButton && event.pressed):
		self.play("on_click")
	if (event is InputEventMouseButton && event.is_released()):
		self.play("click")
