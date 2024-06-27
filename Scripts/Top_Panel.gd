class_name TopPanel extends Node

var stats:Stats

@onready var player_hp = $MarginContainer/HBoxContainer/HPDisplay/PlayerHP
@onready var player_hp_label = $MarginContainer/HBoxContainer/HPDisplay/PlayerHPLabel
@onready var player_coins = $MarginContainer/HBoxContainer/CoinsDisplay/PlayerCoins

var suffixes = ["", "K", "M", "B", "T", "Q", "Qt"]  # Add more suffixes as needed

func load_values():
	update_player_hp()
	update_player_coins()
	
func update_player_coins():
	player_coins.text = format_number(stats.total_coins)
	
func update_player_hp():
	player_hp.set_max(stats.castle_max_hp_stat)
	player_hp.set_value(stats.player_hp)
	player_hp_label.text = format_number(stats.player_hp) + " / " + format_number(stats.castle_max_hp_stat)

func format_number(number):
	var formatted_number = float(number)
	var suffix_index = 0
	
	while formatted_number >= 1000.0 and suffix_index < suffixes.size() - 1:
		formatted_number /= 1000
		suffix_index += 1
	
	if suffix_index == 0 and number == int(number): 
		return str(number)
	return (("%.02f" % formatted_number) + suffixes[suffix_index])
