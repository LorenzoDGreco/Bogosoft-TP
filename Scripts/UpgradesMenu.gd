extends TextureRect

@onready var _pop_text = preload("res://Scenes/pop_text.tscn")
var pop_text_instance

var upgrades : Upgrades
var stats : Stats
var menu_extended = false

func _ready():
	set_initial_gold()
	
func set_initial_gold():
	$TabContainer/Clicks/HBoxContainer/ClickDamage/ButtonClickDamage.text = "100"
	$TabContainer/Clicks/HBoxContainer/ClickArea/ButtonClickArea.text = "10000"
	$TabContainer/Clicks/HBoxContainer/ClickAreaDamage/ButtonClickAreaDamage.text =  "15000"
	
	$TabContainer/Unidades/ScrollContainer/HBoxContainer/UnlockArcher/ButtonUnlockArcher.text = "2500"
	$TabContainer/Unidades/ScrollContainer/HBoxContainer/ArcherDamage/ButtonArcherDamage.text = "500"
	$TabContainer/Unidades/ScrollContainer/HBoxContainer/ArcherAttackSpeed2/ButtonArcherAttackSpeed.text = "5000"
	$TabContainer/Unidades/ScrollContainer/HBoxContainer/ArcherMultiShoot/ButtonArcherMultiShoot.text = "20000"
	
	$TabContainer/Defensas/HBoxContainer/MaxLife/ButtonMaxLife.text = "100"
	
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
	stats.click_damage = upgrades.upgrade_damage_click(stats.click_damage)


func _on_button_unlock_archer_pressed():
	#SPAWN ARCHER ON 
	
	pass # Replace with function body.
