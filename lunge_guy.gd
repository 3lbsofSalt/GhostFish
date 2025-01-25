extends Node2D

@export var speed: float = 40;
@export var health: float = 10;

enum States {LUNGING, TPOSING};
var state: States = States.TPOSING;
var alive = true;
var player_target: Node2D = null;

func _update_state() -> void:
	print('arsiotne');
	var timer: Timer = %StateTimer;
	if state == States.TPOSING:
		state = States.LUNGING;
		$AnimatedSprite2D.play('lunge');
		timer.wait_time = 3;
	elif state == States.LUNGING:
		state = States.TPOSING;
		$AnimatedSprite2D.play('t-pose');
		timer.wait_time = 5;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play('t-pose');

func is_alive() -> bool:
	return alive;

func die() -> void:
	if GameState.is_running():
		GameState.score += 100;
	alive = false;	
	queue_free();

func take_damage(damage = 1) -> void:
	health -= damage;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		die();

	var player = get_tree().get_nodes_in_group('Fish').pick_random();
	if alive and GameState.is_running() and state != States.TPOSING: 
		var next_pos = global_position.move_toward(player.global_position, delta*speed);
		if (global_position - next_pos).x > 0:
			$AnimatedSprite2D.flip_h = true;
		else: 
			$AnimatedSprite2D.flip_h = false;

		global_position = next_pos



func _on_collide(body: Node2D) -> void:
	if body.is_in_group('Fish') and body.has_method('take_damage') and GameState.is_running():
		body.take_damage(10);
