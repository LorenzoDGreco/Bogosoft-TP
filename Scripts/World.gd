class_name World extends Node

const offset_coin = 15

var normal_skeleton : PackedScene = preload("res://Scenes/Normal_Skeleton.tscn")
var warrior_skeleton : PackedScene = preload("res://Scenes/Warrior_Skeleton.tscn")
var mage_skeleton : PackedScene = preload("res://Scenes/Mage_Skeleton.tscn")
var rogue_skeleton : PackedScene = preload("res://Scenes/Rogue_Skeleton.tscn")
var mouse : PackedScene = preload("res://Scenes/Mouse.tscn")
var gold_coin : PackedScene = preload("res://Scenes/Gold_Coin.tscn")
var silver_coin : PackedScene = preload("res://Scenes/Silver_Coin.tscn")

@onready var stats = Stats.new()
@onready var mouse_instance = mouse.instantiate()

@onready var upgrades_panel = $CanvasLayer/UpgradesPanel
@onready var top_panel = $CanvasLayer/TopPanel
@onready var gameover_panel = $CanvasLayer/GameOverPanel
@onready var score_panel = $CanvasLayer/ScorePanel

# Enemy spawning area
var min_spawn_width = -100
var max_spawn_width = -10 # keep under zero!
var max_spawn_height = 160
var min_spawn_height = 50

var game_finished:bool = false

# PANELS AND CONNECTIONS ----------------------------------
func _ready():
	# Initialize Top Panel
	top_panel.stats = stats
	top_panel.load_values()
	
	# Initialize Upgrades Panel (and link to Top Panel for updates)
	upgrades_panel.stats = stats
	upgrades_panel.top_panel = top_panel
	upgrades_panel.load_initial_values()
	
	# Initialize and connect GameOver Panel
	gameover_panel.stats = stats
	gameover_panel.connect("restart_game", _on_restart_button_pressed)
	gameover_panel.connect("quit_game", _on_quit_button_pressed)
	
	# Initialize Score Panel and connect special event signals
	score_panel.stats = stats
	score_panel.load_values()
	score_panel.connect("spawn_boss", spawn_boss)
	
	mouse_instance.stats = stats
	add_child(mouse_instance)

# COINS ---------------------------------------------------
func spawn_coins(position, _amount):
	position.y += offset_coin
	
	# Offset for multiple coin spawn
	var spawn_radius = 20
	var spawn_offset = Vector2(0, 0)
	
	# Signal from Enemy, regular enemy spawns a single coin, bosses spawn 5
	var coin_instance
	for i in _amount:
		# Chance to spawn silver coin instead
		var spawn_type = randf_range(0, 1)
		if spawn_type > 0.95: coin_instance = silver_coin.instantiate()
		else: coin_instance = gold_coin.instantiate()
		
		# Connect and add to scene
		coin_instance.connect("coin_pickUp", _on_coin_pick_up)
		coin_instance.global_position = position + spawn_offset
		get_node("Coins").add_child(coin_instance)
		
		# Randomize next coin position (if boss)
		spawn_offset = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))

func _on_coin_pick_up(coins):
	# Updates the internal total_coins stat
	stats.total_coins += coins * stats.coin_value_multiplier
	# Updates total coins on display
	top_panel.update_player_coins()
	# Updates every upgrade button state
	upgrades_panel.update_upgrade_button_status()

# ENEMIES -------------------------------------------------
func _on_spawn_timer_timeout():
	$SpawnTimer.wait_time = stats.enemy_spawn_rate
	# Enemy spawning logic
	var spawn_amount:int = randi_range(1, stats.enemy_max_spawn_amount)
	for i in spawn_amount:
		var spawn_type:float = randf_range(0, 1)
		if spawn_type > 0.9 and stats.unlock_rogues: spawn_enemy(rogue_skeleton.instantiate())
		elif spawn_type > 0.6 and stats.unlock_warriors: spawn_enemy(warrior_skeleton.instantiate())
		elif spawn_type > 0.4 and stats.unlock_mages: spawn_enemy(mage_skeleton.instantiate())
		else: spawn_enemy(normal_skeleton.instantiate())

func spawn_enemy(new_enemy):
	new_enemy.global_position = Vector2(randf_range(min_spawn_width, max_spawn_width), randf_range(min_spawn_height, max_spawn_height))
	new_enemy.connect("enemy_death", spawn_coins)
	new_enemy.connect("enemy_attack", _on_castle_attacked)
	new_enemy.stats = stats
	get_node("Enemies").add_child(new_enemy)
	
func _on_castle_attacked(damage):
	# Update values on Stats and on the HUD
	stats.take_damage(damage)
	top_panel.update_player_hp()
	
	if (stats.player_hp <= 0 and !game_finished): game_over()

# SPECIAL ENEMIES -----------------------------------------
func spawn_boss():
	var spawn_type:float = randf_range(0, 1)
	var new_boss
	if spawn_type > 0.9 and stats.unlock_rogues: new_boss = rogue_skeleton.instantiate()
	elif spawn_type > 0.6 and stats.unlock_warriors: new_boss = warrior_skeleton.instantiate()
	elif spawn_type > 0.4 and stats.unlock_mages: new_boss = mage_skeleton.instantiate()
	else: new_boss = normal_skeleton.instantiate()
	
	new_boss.global_position = Vector2(randf_range(min_spawn_width, max_spawn_width), (max_spawn_height + min_spawn_height)/2)
	new_boss.connect("enemy_death", spawn_coins)
	new_boss.connect("enemy_attack", _on_castle_attacked)
	new_boss.stats = stats
	new_boss.is_boss = true
	new_boss.apply_scale(Vector2(1.5, 1.5))
	get_node("Enemies").add_child(new_boss)

# ENDING --------------------------------------------------
func game_over():
	game_finished = true
	# Stop spawning new enemies
	$SpawnTimer.set_paused(true)
	
	# Stop increasing time & score
	score_panel.stop_timer()
	
	# Stop every enemy (except if mid-death)
	for e in get_tree().get_nodes_in_group("enemy"):
		if e.get_node("AnimatedSprite2D").get_animation() != "death":
			e.get_node("AnimatedSprite2D").play("default")
		e.speed = 0
		
	# Stop coin autocollect
	for c in get_tree().get_nodes_in_group("coin"):
		c.get_node("Timer").set_paused(true)
		
	# Stop archers from shooting
	for a in get_tree().get_nodes_in_group("archer"):
		a.get_node("Timer").set_paused(true)
	
	# Hide upgrades and show GameOver panel
	upgrades_panel.set_visible(false)
	gameover_panel.load_values()
	gameover_panel.set_visible(true)
	
func _on_restart_button_pressed():
	gameover_panel.set_visible(false)
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().quit()
