extends TextureRect

@onready var _pop_text = preload("res://Scenes/pop_text.tscn")
var pop_text_instance

var upgrades : Upgrades
var menu_extended = false

func _on_slide_pressed():
	if menu_extended: slide_out()
	else: slide_in()
	menu_extended = not menu_extended

func slide_in():
	var slide_tween = get_tree().create_tween()
	slide_tween.tween_property(self, "position", Vector2(232, 175), 0.5)

func slide_out():
	if pop_text_instance != null:
		pop_text_instance.close()
		
	var slide_tween = get_tree().create_tween()
	slide_tween.tween_property(self, "position", Vector2(375, 175), 0.5)

func _on_tab_container_tab_changed(tab):
	if pop_text_instance != null:
		pop_text_instance.close()

func _on_text_click_damage_pressed():
	if pop_text_instance != null:
		pop_text_instance.close()
		return
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Damage Increase", 
		"This upgrade increases the damage dealt by the player's active clicks.\n\nCurrent damage:\nDamage Next level:")
	add_child(pop_text_instance)

func _on_button_click_damage_pressed():
	upgrades.upgrade_damage_click()
