extends Control

var stats:Stats

@onready var time_label = $Time
@onready var score_label = $Score

var formatted_time:String

signal spawn_boss

func _on_timer_timeout():
	stats.time += 1
	stats.score += 1
	
	get_time()
	
	time_label.text = "Time: " + formatted_time + "⧗"
	score_label.text = "Score: " + str(stats.score)

func get_time():
	var hours = stats.time / 3600
	var minutes = (stats.time % 3600) / 60
	var seconds = stats.time % 60
	
	if hours < 1 :	formatted_time = "%02d:%02d" % [minutes, seconds]
	else:	formatted_time = "%02d:%02d:%02d" % [hours, minutes, seconds]
	
	if seconds == 10 : spawn_boss.emit()

func stop_timer():
	$Timer.stop()
