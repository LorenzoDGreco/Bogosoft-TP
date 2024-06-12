class_name Upgrades extends Node

const damage_multiplier = 2  # Factor de multiplicación para el crecimiento exponencial reducido
const max_increment = 100  # Valor máximo de incremento del daño

const area_increment = 1.2
const archer_speed_decrement = 0.8

var max_hp_castle : int = 100 

func generic_update(var_to_update): #Buscar un mejor escalado
	if var_to_update < max_increment: var_to_update = int(var_to_update * damage_multiplier)
	else: var_to_update += max_increment
	return var_to_update

func generic_update_float(var_to_update, scale):
	if var_to_update == 0:
		return 17
	var_to_update *= scale 
	return var_to_update

func upgrade_damage_click(damage_click):
	return generic_update(damage_click)

func upgrade_area_click(area_click):
	return generic_update_float(area_click, area_increment)
	
func upgrade_area_damage(area_damage):
	return generic_update(area_damage)
	
func unlock_archer():
	pass
	
func upgrade_archer_damage(archer_damage):
	return generic_update(archer_damage)
	
func upgrade_archer_speed(archer_speed):
	return generic_update_float(archer_speed, archer_speed_decrement)
	
func upgrade_archer_multishoot():
	pass

