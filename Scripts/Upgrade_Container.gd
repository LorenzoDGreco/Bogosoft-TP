extends Node

# This class will update all the parameters on an upgrade
# 1. whenever the upgrade button is pressed, every stat should upgrade
# 2. enable or disable the upgrade button, based on the total coins

var suffixes = ["", "K", "M", "B", "T", "Q", "Qt"]  # Add more suffixes as needed

func load_values(level, stat, cost, next):
	# Formats values and fills the labels (extra conditions for Healing upgrade)
	if level != null: $CurrentLevel.text = "LV." + str(level)
	if stat is String: $CurrentStat.text = stat 
	else: $CurrentStat.text = format_number(stat)
	$UpgradeButton.text = format_number(cost)
	if next != null: $NextStat.text = format_number(next)

func update_button_status(state):
	$UpgradeButton.set_disabled(state)
	
	# Changes color of next label (except Healing upgrade)
	if self.has_node("NextStat"):
		if state: $NextStat.modulate = Color("#8f8f8f")
		else: $NextStat.modulate = Color("#09ff00")

func format_number(number):
	var formatted_number = float(number)
	var suffix_index = 0
	
	while formatted_number >= 1000.0 and suffix_index < suffixes.size() - 1:
		formatted_number /= 1000
		suffix_index += 1
	
	# Returns whole number if under 1000, otherwise formats to float
	if suffix_index == 0 and number == int(number): 
		return str(number)
	return (("%.02f" % formatted_number) + suffixes[suffix_index])
