class_name Stats extends Node

var upgrades:Upgrades = Upgrades.new()

# Difficulty Stats Multipliers
var enemy_life = 1
var enemy_damage = 1
var enemy_attack_speed = 1
var coin_value : int = 10

# INITIAL STATS -------------------------------------------
# Click Upgrades
var click_damage_level:int = 1
var click_damage_stat = 1
var click_damage_cost:int = 100
var click_damage_next

var click_area_size_level:int = 0
var click_area_size_stat = 0
var click_area_size_cost:int = 250
var click_area_size_next

var click_area_damage_level:int = 1
var click_area_damage_stat = 1
var click_area_damage_cost:int = 400
var click_area_damage_next

# Unit Upgrades
var number_archers_level:int = 0
var number_archers_stat = 0
var number_archers_cost:int = 300
var number_archers_next

var arrow_damage_level:int = 1
var arrow_damage_stat = 1
var arrow_damage_cost:int = 100
var arrow_damage_next

var arrow_cooldown_level:int = 1
var arrow_cooldown_stat = 3
var arrow_cooldown_cost:int = 100
var arrow_cooldown_next

var number_arrows_level:int = 1
var number_arrows_stat = 1
var number_arrows_cost:int = 1000
var number_arrows_next

# Defense Upgrades
var castle_max_hp_level:int = 1
var castle_max_hp_stat = 100
var castle_max_hp_cost:int = 1000
var castle_max_hp_next

var castle_repairs_cost:int = castle_max_hp_cost / 4


# PLAYER GAME STATS ---------------------------------------
var wave_number:int = 0
var time_elapsed:int = 0
var enemies_killed:int = 0
var total_coins:int = 10000
var player_hp = 10


func _init():
	# Initialize the 'next' values of every upgrade HERE
	click_damage_next = upgrades.generic_update(click_damage_stat)
	click_area_size_next = upgrades.generic_update_float(click_area_size_stat, true)
	click_area_damage_next = upgrades.generic_update(click_area_damage_stat)
	
	number_archers_next = number_archers_stat + 1
	arrow_damage_next = upgrades.generic_update(arrow_damage_stat)
	arrow_cooldown_next = upgrades.generic_update_float(arrow_cooldown_stat, false)
	number_arrows_next = number_arrows_stat + 1
	
	castle_max_hp_next = castle_max_hp_stat + 100


# STAT UPGRADE FUNCTIONS ----------------------------------
func upgrade_click_damage():
	total_coins -= click_damage_cost
	
	click_damage_level += 1
	click_damage_stat = click_damage_next
	click_damage_cost *= 2
	click_damage_next = upgrades.generic_update(click_damage_stat)

func upgrade_click_area_size():
	total_coins -= click_area_size_cost
	
	click_area_size_level += 1
	click_area_size_stat = click_area_size_next
	click_area_size_cost *= 2
	click_area_size_next = upgrades.generic_update_float(click_area_size_stat, true)

func upgrade_click_area_damage():
	total_coins -= click_area_damage_cost
	
	click_area_damage_level += 1
	click_area_damage_stat = click_area_damage_next
	click_area_damage_cost *= 2
	click_area_damage_next = upgrades.generic_update(click_area_damage_stat)

func upgrade_number_archers():
	total_coins -= number_archers_cost
	
	number_archers_level += 1
	number_archers_stat = number_archers_next
	number_archers_cost *= 2
	number_archers_next = number_archers_stat + 1
	
func upgrade_arrow_damage():
	total_coins -= arrow_damage_cost
	
	arrow_damage_level += 1
	arrow_damage_stat = arrow_damage_next
	arrow_damage_cost *= 2
	arrow_damage_next = upgrades.generic_update(arrow_damage_stat)
	
func upgrade_arrow_cooldown():
	total_coins -= arrow_cooldown_cost
	
	arrow_cooldown_level += 1
	arrow_cooldown_stat = arrow_cooldown_next
	arrow_cooldown_cost *= 2
	arrow_cooldown_next = upgrades.generic_update_float(arrow_cooldown_stat, false)
	
func upgrade_number_arrows():
	total_coins -= number_arrows_cost
	
	number_arrows_level += 1
	number_arrows_stat = number_arrows_next
	number_arrows_cost *= 2
	number_arrows_next = number_arrows_stat + 1

func upgrade_castle_repairs():
	total_coins -= castle_repairs_cost
	
	# Depending on player_hp, heals 25% or caps at max_hp
	if (player_hp + castle_max_hp_stat / 4) > castle_max_hp_stat:
		player_hp = castle_max_hp_stat
	else: player_hp += castle_max_hp_stat / 4

func upgrade_castle_max_hp():
	total_coins -= castle_max_hp_cost
	
	castle_max_hp_level += 1
	castle_max_hp_stat = castle_max_hp_next
	castle_max_hp_cost *= 2
	castle_max_hp_next = castle_max_hp_stat + 100
	
	# Also fully heals, and increases heal cost
	player_hp = castle_max_hp_stat
	castle_repairs_cost = castle_max_hp_cost / 4

func take_damage(damage):
	# Depending on player_hp, take damage amount or stop at zero
	if (player_hp - damage) <= 0:
		player_hp = 0
	else: player_hp -= damage
