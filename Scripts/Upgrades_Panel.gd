class_name UpgradesPanel extends Node

@onready var tab_container = $MarginContainer/TabContainer

# Importing external scripts and scenes
var archer : PackedScene = preload("res://Scenes/Archer.tscn")
@onready var _pop_text = preload("res://Scenes/pop_text.tscn")
var pop_text_instance

# Recieved from World
var upgrades : Upgrades
var stats : Stats

func _ready():
	# Should initialize all the labels and prices here
	#load_values(stats)
	pass

# Upgrades' pop text behavior ------------------------
func _close_preexisting_pop_text():
	if pop_text_instance != null:
		pop_text_instance.close()
		return

# Tab switching and sliding -------------------------------
func _on_tab_container_tab_changed(_tab):
	_close_preexisting_pop_text()

func _on_clicks_button_pressed():
	tab_container.set_current_tab(0)

func _on_units_button_pressed():
	tab_container.set_current_tab(1)

func _on_defenses_button_pressed():
	tab_container.set_current_tab(2)

func _on_slider_button_toggled(toggled_on):
	_close_preexisting_pop_text()
	
	var slide_tween = get_tree().create_tween()
	if toggled_on: 
		slide_tween.tween_property(self, "position", Vector2(0, 224), 0.25)
		$SliderButton.set_text("▲ Upgrades")
	else: 
		slide_tween.tween_property(self, "position", Vector2(0, 174), 0.25)
		$SliderButton.set_text("▼ Upgrades")


# CLICKS UPGRADES -----------------------------------------
# Click Damage container ----------------------------------
func _on_click_damage_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Click Damage [Q]", 
		"Increases the damage dealt by the player's active clicks.")
	add_child(pop_text_instance)

func _on_click_damage_upgrade_button_pressed():
	upgrades.upgrade_click_damage()
	tab_container.get_node("ClicksPanel/VBoxContainer/ClickDamageContainer").load_values(
		stats.click_damage_level, stats.click_damage_stat, stats.click_damage_cost, stats.click_damage_next
	)
	update_upgrade_button_status()

# Click Area Size container -------------------------------
func _on_click_area_size_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Click Area Size [W]", 
		"Expands the size of the damaging area surrounding a ​​click.")
	add_child(pop_text_instance)

func _on_click_area_size_upgrade_button_pressed():
	stats.area_click = upgrades.upgrade_area_click(stats.area_click)
	# print(stats.area_click)

# Click Area Damage container -----------------------------
func _on_click_area_damage_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Click Area Damage [E]", 
		"Increases the damage of the area surrounding a click.")
	add_child(pop_text_instance)

func _on_click_area_damage_upgrade_button_pressed():
	stats.area_damage = upgrades.upgrade_area_damage(stats.area_damage)


# UNITS UPGRADES ------------------------------------------
# +1 Archer container -------------------------------------
func _on_number_archers_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"+1 Archer [A]", 
		"Places an additional archer, fires arrows automatically.")
	add_child(pop_text_instance)

func _on_number_archers_upgrade_button_pressed():
	var new_archer = archer.instantiate()
	if stats.archer == 0:
		new_archer.global_position = Vector2(361, 16)
	elif stats.archer == 1:
		new_archer.global_position = Vector2(361, 65)
	elif stats.archer == 2:
		new_archer.global_position = Vector2(361, 155)
	elif stats.archer == 3:
		new_archer.global_position = Vector2(361, 191)
	
	new_archer.stats = stats
	stats.archer += 1
	
	get_parent().get_parent().get_node("Defences").add_child(new_archer)
	
	# SWAP OUT ARCHERS FOR ARROWS IF MAX ARCHERS
	if stats.archer == 4:
		tab_container.get_node("UnitsPanel/VBoxContainer/HBoxContainer").set_visible(false)
		tab_container.get_node("UnitsPanel/VBoxContainer/HBoxContainer4").set_visible(true)

# Arrow Damage container ----------------------------------
func _on_arrow_damage_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Arrow Damage [S]", 
		"Increases the damage of a fired arrow.")
	add_child(pop_text_instance)

func _on_arrow_damage_upgrade_button_pressed():
	stats.archer_damage = upgrades.upgrade_archer_damage(stats.archer_damage)

# Arrow Cooldown container --------------------------------
func _on_arrow_cooldown_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Arrow Cooldown [D]", 
		"Decreases the time between arrows fired.")
	add_child(pop_text_instance)

func _on_arrow_cooldown_upgrade_button_pressed():
	stats.archer_speed = upgrades.upgrade_archer_speed(stats.archer_speed)
	print(stats.archer_speed)

# +1 Arrow container --------------------------------------
func _on_number_arrows_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"+1 Arrow [F]", 
		"Fires an additional arrow per shot.")
	add_child(pop_text_instance)

func _on_number_arrows_upgrade_button_pressed():
	pass # Replace with function body.


# DEFENSES UPGRADES ---------------------------------------
# Castle Repairs container --------------------------------
func _on_castle_repairs_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Castle Repairs [X]", 
		"Instantly recovers a fixed amount of HP.")
	add_child(pop_text_instance)
	
func _on_castle_repairs_upgrade_button_pressed():
	pass # Replace with function body.

# Castle Max HP container ---------------------------------
func _on_castle_max_hp_texture_button_pressed():
	_close_preexisting_pop_text()
	
	pop_text_instance = _pop_text.instantiate()
	pop_text_instance.position = Vector2(468, 5)
	pop_text_instance.set_text(
		"Castle Max HP [Z]", 
		"Increases the castle's maximum health points.")
	add_child(pop_text_instance)
	
func _on_castle_max_hp_upgrade_button_pressed():
	pass # Replace with function body.


# Keyboard Inputs -----------------------------------------
func _unhandled_key_input (event):
	if Input.is_action_just_pressed("upgclick"):
		_on_click_damage_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgarea"):
		_on_click_area_size_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgareadmg"):
		_on_click_area_damage_upgrade_button_pressed()
	elif Input.is_action_just_pressed("unlockarcher"):
		_on_number_archers_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgarchdmg"):
		_on_arrow_damage_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgarchas"):
		_on_arrow_cooldown_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgarchmultishot"):
		_on_number_arrows_upgrade_button_pressed()
	elif Input.is_action_just_pressed("upgmaxlife"):
		_on_castle_max_hp_upgrade_button_pressed()
	# ADD REPAIRS KEYBIND


# Loading elements values ---------------------------------
func load_starting_values():
	# Loads initial values of every container at startup
	# DONE: update values after upgrading!
	# TODO: decrease coins after upgrading!
	# TODO: apply to every upgrade container!
	# TODO: apply modifications to specific upgrades (i.e. Archer LV0, Repairs, etc.)
	# Clicks upgrades -------------------------------------
	stats.click_damage_next = upgrades.generic_update(stats.click_damage_stat)
	tab_container.get_node("ClicksPanel/VBoxContainer/ClickDamageContainer").load_values(
		stats.click_damage_level, stats.click_damage_stat, stats.click_damage_cost, stats.click_damage_next
	)
	update_upgrade_button_status()

func update_upgrade_button_status():
	# Updates upgrade buttons state globally
	# Runs at startup, then on every coin collected
	tab_container.get_node("ClicksPanel/VBoxContainer/ClickDamageContainer").update_button_status(
		stats.total_coins < stats.click_damage_cost
	)
	
func update_stats(name, level, stat, cost, next):
	stats.upgrade_data[name].current_level += 1
	stats.upgrade_data[name].current_stat = stats.upgrade_data[name].next_stat
	stats.upgrade_date[name].upgrade_cost *= 2
	stats.upgrade_data[name].next_stat = upgrades.generic_update(stat)
