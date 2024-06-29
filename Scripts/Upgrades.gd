class_name Upgrades extends Node

# For generic_update
const multiplier = 2 
const max_increment = 100

# For generic_update_float
const delta_upgrade = 0.2

func generic_update(var_to_update):
	if var_to_update < max_increment: var_to_update = int(var_to_update * multiplier)
	else: var_to_update += max_increment
	return var_to_update

func generic_update_float(var_to_update, increase):
	if !increase and var_to_update <= 0.5: return 0.5
	if var_to_update == 0: return 1 # First Area Size upgrade
	
	if increase: var_to_update *= (1 + delta_upgrade)
	else: var_to_update *= (1 - delta_upgrade)
	return var_to_update
