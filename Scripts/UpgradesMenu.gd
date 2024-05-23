extends TextureRect

var archer : PackedScene = preload("res://Scenes/Archer.tscn")

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


func _on_button_unlock_archer_pressed():
	#SPAWN ARCHER ON 
	#if HAY PLATA O NO HAY PLATAAAAA
	var arch = archer.instantiate()
	if stats.archer == 0:
		arch.global_position = Vector2(361, 16)
		arch.stats = stats
		stats.archer += 1
	elif stats.archer == 1:
		arch.global_position = Vector2(361, 65)
		arch.stats = stats
		stats.archer += 1
	elif stats.archer == 2:
		arch.global_position = Vector2(361, 155)
		arch.stats = stats
		stats.archer += 1
	elif stats.archer == 3:
		arch.global_position = Vector2(361, 191)
		arch.stats = stats
		stats.archer += 1
	else:
		return
	get_parent().get_parent().add_child(arch)


func _pop_text_create():
	if pop_text_instance != null:
		pop_text_instance.close()
		return
	
#MEJORAS CLICK
func _on_text_click_damage_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Damage Increase", 
		"This upgrade increases the damage dealt by the player's active clicks.\n\nCurrent Click damage:\nDamage Next level:")
	add_child(pop_text_instance)

func _on_button_click_damage_pressed():
	stats.click_damage = upgrades.upgrade_damage_click(stats.click_damage)



func _on_text_click_area_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Increases the area of ​​click damage", 
		"This upgrade increases the area of ​​click damage.")
	add_child(pop_text_instance)


func _on_text_click_area_damage_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Area Damage Increase", 
		"This upgrade increases the damage dealt by the player's active clicks Area.\n\nCurrent Area damage:\nDamage Next level:")
	add_child(pop_text_instance)


func _on_button_click_area_damage_pressed():
	stats.area_damage = upgrades.upgrade_area_damage(stats.area_damage)


#UNIDADES(Solo Arqueros por ahora)
func _on_text_unlock_archer_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Archer", 
		"This unit attacks enemies automatically\n\nCurrent Archers(Max 4):")
	add_child(pop_text_instance)

	
func _on_text_archer_damage_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Archer Damage", 
		"This upgrade increases Archer's damage\n\nCurrent damage:\nDamage Next level:")
	add_child(pop_text_instance)


func _on_button_archer_damage_pressed():
	stats.archer_damage = upgrades.upgrade_archer_damage(stats.archer_damage)


func _on_text_archer_attack_speed_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Archer Attack Speed", 
		"This upgrade increases Archer's attack speed\n\nCurrent attack speed:\nAttack speed Next level:")
	add_child(pop_text_instance)


func _on_text_archer_multi_shoot_pressed():
	_pop_text_create()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(-80, -5)
	pop_text_instance.set_text(
		"Archer Multishot", 
		"This upgrade actives multishot for Archers\n\nCurrent arrows shooted:\nArrows Shooted Next level:")
	add_child(pop_text_instance)


