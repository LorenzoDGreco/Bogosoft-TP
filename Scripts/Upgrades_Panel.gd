class_name UpgradesPanel extends Node

@onready var tab_container = $MarginContainer/TabContainer

func _on_clicks_button_pressed():
	tab_container.set_current_tab(0)

func _on_units_button_pressed():
	tab_container.set_current_tab(1)

func _on_defenses_button_pressed():
	tab_container.set_current_tab(2)

func _on_slider_button_toggled(toggled_on):
	var slide_tween = get_tree().create_tween()
	if toggled_on: 
		slide_tween.tween_property(self, "position", Vector2(0, 224), 0.25)
		$SliderButton.set_text("▲ Upgrades")
	else: 
		slide_tween.tween_property(self, "position", Vector2(0, 174), 0.25)
		$SliderButton.set_text("▼ Upgrades")
