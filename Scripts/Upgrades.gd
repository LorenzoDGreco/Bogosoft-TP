class_name Upgrades extends Node

var damage_multiplier = 2  # Factor de multiplicación para el crecimiento exponencial reducido
var max_increment = 100  # Valor máximo de incremento del daño

var damage_click : int = 1
var area_click : float = 0
var area_damage : int = 0

var archer : int = 0
var archer_damage : int = 1
var archer_speed : float = 3
var archer_multishoot : int = 1

var max_hp_castle : int = 100

func generic_update(var_to_update): #Buscar un mejor escalado
	if var_to_update < max_increment: var_to_update = int(var_to_update * damage_multiplier)
	else: var_to_update += max_increment
	return var_to_update

func upgrade_damage_click():
	damage_click = generic_update(damage_click)

func upgrade_area_click():
	pass
	
func upgrade_area_damage():
	pass
	
func unlock_archer():
	pass
	
func upgrade_archer_damage():
	pass
	
func upgrade_archer_speed():
	pass
	
func upgrade_archer_multishoot():
	pass
