class_name pop_text extends TextureRect

func set_text(title, details):
	$Title.text = title
	$Details.text = details

func _on_button_pressed():
	queue_free()

func close():
	queue_free()
