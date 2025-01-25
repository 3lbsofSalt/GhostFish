extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_pressed() -> void:
	GameState.score = 0.0;
	GameState.pearls_collected = 0;
	GameState.enemy_speed_mean = 50;
	GameState.enemy_speed_std = 10;
	
	get_tree().change_scene_to_file("res://scenes/newRoot.tscn")
