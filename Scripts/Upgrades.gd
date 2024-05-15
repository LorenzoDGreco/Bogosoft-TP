extends TextureRect


var menu_extended = false

func _on_button_pressed():
	if menu_extended: slide_out()
	else: slide_in()
	menu_extended = not menu_extended

func slide_in():
	var slide_tween = get_tree().create_tween()
	slide_tween.tween_property(self, "position", Vector2(255, 175), 0.5)

func slide_out():
	var slide_tween = get_tree().create_tween()
	slide_tween.tween_property(self, "position", Vector2(375, 175), 0.5)
