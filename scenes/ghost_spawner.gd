extends Marker2D

@export var spawn_chance: float = 20; # Out of 100%
@export var spawn: PackedScene = load("res://scenes/BasicGhost.tscn");


func random_normal(mean: float, stddev: float) -> float:
	# Generate two uniformly distributed random numbers between 0 and 1
	var u1 = randf()
	var u2 = randf()
	
	# Apply the Box-Muller transform to generate a normally distributed value
	var z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * PI * u2)
	# Scale and shift to match the desired mean and standard deviation
	return z0 * stddev + mean

func _on_spawn_timer_timeout() -> void:
	var rand = randf_range(0, 100);
	if rand <= spawn_chance:
		var enemy: Node2D = spawn.instantiate();
		enemy.global_position = global_position;
		var speed = random_normal(enemy.speed_mean, enemy.speed_std)
		enemy.speed = speed
		# enemy.global_position = global_position;
		get_tree().root.add_child(enemy);
