class_name TopPanel extends Node

var stats:Stats

@onready var player_hp = $MarginContainer/HBoxContainer/HPDisplay/PlayerHP
@onready var player_hp_label = $MarginContainer/HBoxContainer/HPDisplay/PlayerHPLabel
@onready var player_coins = $MarginContainer/HBoxContainer/CoinsDisplay/PlayerCoins

func load_values():
	update_player_hp()
	update_player_coins()
	
func update_player_coins():
	player_coins.text = str(stats.total_coins)
	
func update_player_hp():
	player_hp.set_max(stats.castle_max_hp_stat)
	player_hp.set_value(stats.player_hp)
	player_hp_label.text = str(stats.player_hp) + " / " + str(stats.castle_max_hp_stat)
