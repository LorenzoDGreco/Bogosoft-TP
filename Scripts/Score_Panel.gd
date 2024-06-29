extends Node

var stats:Stats

@onready var time_label = $MarginContainer/HBoxContainer/TimeContainer/Label
@onready var score_label = $MarginContainer/HBoxContainer/ScoreContainer/Label

# Signals sent to World
signal spawn_boss
signal unlock_warriors
signal unlock_mages

func _on_timer_timeout():
	stats.time += 1
	stats.score += 1
	load_values()
	manage_game_events()

func load_values():
	time_label.text = format_time()
	score_label.text = str(stats.score)

func format_time():
	var hours = stats.time / 3600
	var minutes = (stats.time % 3600) / 60
	var seconds = stats.time % 60
	
	if hours < 1: return "%02d:%02d" % [minutes, seconds]
	else: return "%02d:%02d:%02d" % [hours, minutes, seconds]

func manage_game_events():
	# Emit special event signals / adjust difficulty HERE
	# (starts checking from second 1)
	
	# Boss Enemy every minute
	if stats.time % 60 == 0: spawn_boss.emit()
	
	# Unlock more enemy types
	if stats.time == 60: unlock_warriors.emit()
	if stats.time == 120 : unlock_mages.emit()

func stop_timer():
	$Timer.stop()
