extends Node

var score = 0.0;
var pearls_collected = 0;
var enemy_speed_mean = 300;
var enemy_speed_std = 100;
var boss_defeated = false;
var spawn_rate: float = 50;
var spawn_chance = 1

'''
func enemies_should_spawn() -> bool:
	if %Map and %Map.has_method('player_in_ship'):
		return %Map.player_in_ship()
	else:
		return true;
'''

func is_running() -> bool:
	var players: Array[Node] = get_tree().get_nodes_in_group('Fish');
	var players_alive: int = 0;
	for player in players:
		if player.has_method('is_alive') and player.is_alive():
			players_alive = players_alive + 1;
	
	if boss_defeated:
		get_tree().change_scene_to_file("res://scenes/you_won.tscn")
		return false
		
	if players_alive > 0:
		return true;
	else:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
		return false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().change_scene_to_file("res://scenes/startupscene.tscn")
