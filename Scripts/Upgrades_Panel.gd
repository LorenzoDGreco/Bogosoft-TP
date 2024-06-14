class_name UpgradesPanel extends Node

@onready var tab_container = $MarginContainer/TabContainer

# Importing external scripts and scenes
var archer : PackedScene = preload("res://Scenes/Archer.tscn")
@onready var _pop_text = preload("res://Scenes/pop_text.tscn")
var pop_text_instance

# Upgrade Container scenes
@onready var click_damage = $MarginContainer/TabContainer/ClicksPanel/VBoxContainer/ClickDamageContainer
@onready var click_area_size = $MarginContainer/TabContainer/ClicksPanel/VBoxContainer/ClickAreaSizeContainer
@onready var click_area_damage = $MarginContainer/TabContainer/ClicksPanel/VBoxContainer/ClickAreaDamageContainer
@onready var number_archers = $MarginContainer/TabContainer/UnitsPanel/VBoxContainer/NumberArchersContainer
@onready var arrow_damage = $MarginContainer/TabContainer/UnitsPanel/VBoxContainer/ArrowDamageContainer
@onready var arrow_cooldown = $MarginContainer/TabContainer/UnitsPanel/VBoxContainer/ArrowCooldownContainer
@onready var number_arrows = $MarginContainer/TabContainer/UnitsPanel/VBoxContainer/NumberArrowsContainer
@onready var castle_repairs = $MarginContainer/TabContainer/DefensesPanel/VBoxContainer/CastleRepairsContainer
@onready var castle_max_hp = $MarginContainer/TabContainer/DefensesPanel/VBoxContainer/CastleMaxHPContainer

# Recieved from World
var stats:Stats
var top_panel:TopPanel

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
	# Extra check in case of KeyboardInput
	if stats.total_coins < stats.click_damage_cost: return
	
	# Stats upgrades (coin, level, stat, etc.)
	stats.upgrade_click_damage()
	
	# UI updates (coins on topbar, upgrade_container, every upgrade_button)
	top_panel.update_player_coins()
	click_damage.load_values(stats.click_damage_level, stats.click_damage_stat, stats.click_damage_cost, stats.click_damage_next)
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
	# Extra check in case of KeyboardInput
	if stats.total_coins < stats.click_area_size_cost: return
	
	# Stats upgrades (coin, level, stat, etc.)
	stats.upgrade_click_area_size()
	
	# UI updates (coins on topbar, upgrade_container, every upgrade_button)
	top_panel.update_player_coins()
	click_area_size.load_values(stats.click_area_size_level, stats.click_area_size_stat, stats.click_area_size_cost, stats.click_area_size_next)
	update_upgrade_button_status()
	
	# If upgraded once, click_area_damage container appears
	click_area_damage.set_visible(true)

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
	# Extra check in case of KeyboardInput
	if stats.total_coins < stats.click_area_damage_cost or stats.click_area_size_stat == 0:
		return
	
	# Stats upgrades (coin, level, stat, etc.)
	stats.upgrade_click_area_damage()
	
	# UI updates (coins on topbar, upgrade_container, every upgrade_button)
	top_panel.update_player_coins()
	click_area_damage.load_values(stats.click_area_damage_level, stats.click_area_damage_stat, stats.click_area_damage_cost, stats.click_area_damage_next)
	update_upgrade_button_status()


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
		number_archers.set_visible(false)
		number_arrows.set_visible(true)

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
	#stats.archer_damage = upgrades.upgrade_archer_damage(stats.archer_damage)
	pass

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
	#stats.archer_speed = upgrades.upgrade_archer_speed(stats.archer_speed)
	#print(stats.archer_speed)
	pass

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
func load_initial_values():
	# Loads initial values of every container at startup
	# DONE: update values after upgrading (on upgrade event -> upgrade_panel)
	# DONE: decrease coins after upgrading (on upgrade event -> top_panel)
	# TODO: apply to every upgrade container!
	# TODO: apply modifications to specific upgrades (i.e. Archer LV0, Repairs, etc.)
	# Clicks upgrades -------------------------------------
	click_damage.load_values(stats.click_damage_level, stats.click_damage_stat, stats.click_damage_cost, stats.click_damage_next)
	click_area_size.load_values(stats.click_area_size_level, stats.click_area_size_stat, stats.click_area_size_cost, stats.click_area_size_next)
	click_area_damage.load_values(stats.click_area_damage_level, stats.click_area_damage_stat, stats.click_area_damage_cost, stats.click_area_damage_next)
	
	update_upgrade_button_status()

func update_upgrade_button_status():
	# Runs at startup, after collecting a coin, and after buying an upgrade
	click_damage.update_button_status(stats.total_coins < stats.click_damage_cost)
	click_area_size.update_button_status(stats.total_coins < stats.click_area_size_cost)
	click_area_damage.update_button_status(stats.total_coins < stats.click_area_damage_cost)
	
