extends AnimatedSprite2D

var click_damage = preload("res://Scenes/Click_Damage.tscn")
var click_area = preload("res://Scenes/Click_Area.tscn")
var click_damage_instance
var click_area_instance

var stats : Stats

func _process(_delta):
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), Input.CURSOR_ARROW, Vector2(sprite_frames.get_frame_texture(animation, frame).get_width(), sprite_frames.get_frame_texture(animation, frame).get_height()) / 2)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		self.play("on_click")
		click_damage_instance = click_damage.instantiate()
		click_damage_instance.stats = stats
		click_damage_instance.global_position = get_global_mouse_position()
		get_parent().add_child(click_damage_instance)
		
		if stats.click_area_size_stat != 0:
			click_area_instance = click_area.instantiate()
			click_area_instance.stats = stats
			click_area_instance.global_position = get_global_mouse_position()
			get_parent().add_child(click_area_instance)
		
	if event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		self.play("click")
