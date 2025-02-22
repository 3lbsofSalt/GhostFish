extends Node2D

var speed = 10;
@export var speed_mean: float = 200;
@export var speed_std: float = 100;
@export var health: float = 1;
var death_sound_connected = false;

signal dieSig();

var alive = true;
var player_target: Node2D = null;
@onready var sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play('default')

func is_alive() -> bool:
	return alive;

func die() -> void:
	if GameState.is_running():
		GameState.score += 10;
	emit_signal("dieSig");
	alive = false;	
	queue_free();

func take_damage(damage = 1) -> void:
	health -= damage;
	$GhostGetsHit.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		die();

	var player = get_tree().get_nodes_in_group('Fish').pick_random();
	if not GameState.is_running():
		die();

	if alive and GameState.is_running(): 
		global_position = global_position.move_toward(player.global_position, delta*speed);
		if global_position.x > player.global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		


func _on_collide(body: Node2D) -> void:
	if body.is_in_group('Fish') and body.has_method('take_damage') and GameState.is_running():
		body.take_damage(1);
		take_damage();
