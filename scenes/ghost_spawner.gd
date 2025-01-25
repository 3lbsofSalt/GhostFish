extends Marker2D

@export var spawn_chance: float = 20; # Out of 100%
@export var spawn: PackedScene = load("res://scenes/BasicGhost.tscn");

func _on_spawn_timer_timeout() -> void:
	var rand = randf_range(0, 100);
	print(GameState.enemies_should_spawn());
	if rand <= spawn_chance and GameState.enemies_should_spawn():
		var enemy: Node2D = spawn.instantiate();
		enemy.global_position = global_position;
		# enemy.global_position = global_position;
		get_tree().root.add_child(enemy);
