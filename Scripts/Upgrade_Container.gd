extends Node

# This class will update all the parameters on an upgrade
# 1. whenever the upgrade button is pressed, every stat should upgrade
# 2. enable or disable the upgrade button, based on the total coins

func load_values(level, stat, cost, next):
	$CurrentLevel.text = "LV." + str(level)
	$CurrentStat.text = str(stat)
	$UpgradeButton.text = price_format(cost)
	$NextStat.text = str(next)

func update_button_status(state):
	$UpgradeButton.set_disabled(state)

func price_format(price):
	# TODO: Format the button label with the corresponding units
	return str(price)
