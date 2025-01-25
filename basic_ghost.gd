extends Node2D

@export var speed = 20;

var alive = true;
var player_target: Node2D = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func die() -> void:
	alive = false;	
	queue_free();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_tree().get_nodes_in_group('Fish').pick_random();
	if alive: 
		global_position = global_position.move_toward(player.global_position, delta*speed);



func _on_collide(body: Node2D) -> void:
	if body.is_in_group('Fish') and body.has_method('take_damage'):
		body.take_damage();
	else:
		print(body.is_in_group('Fish'))
		print(body.has_method('take_damage'))
