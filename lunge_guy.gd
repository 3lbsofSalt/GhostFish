extends Node2D

@onready var SCREEN_WIDTH = 1152
@onready var SCREEN_HEIGHT = 648

@export var speed: float = 40;
@export var health: float = 10;

@onready var camera = get_tree().current_scene.get_node("Camera");

enum States {LUNGING, TPOSING};
var state: States = States.TPOSING;
var alive = true;
var player_target: Node2D = null;

func _update_state() -> void:
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
	modulate = Color(1, .5, .5, 1);
	var hitTween = create_tween();
	hitTween.parallel().tween_property(self, "modulate", Color(1, 1, 1, 1), .25);
	#print("BUTLER HEALTH ", health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		die();

	var player = get_tree().get_nodes_in_group('Fish').pick_random();
	if alive and isOnScreen() and GameState.is_running() and state != States.TPOSING: 
		var next_pos = global_position.move_toward(player.global_position, delta*speed);
		if (global_position - next_pos).x > 0:
			$AnimatedSprite2D.flip_h = true;
		else: 
			$AnimatedSprite2D.flip_h = false;

		global_position = next_pos



func _on_collide(body: Node2D) -> void:
	if body.is_in_group('Fish') and body.has_method('take_damage') and GameState.is_running():
		body.take_damage(10);
		
		
func isOnScreen():
	var onScreen = false;
	var goodX = global_position.x > camera.position.x and global_position.x < camera.position.x + SCREEN_WIDTH;
	var goodY = global_position.y > camera.position.y and global_position.y < camera.position.y + SCREEN_HEIGHT;
	if goodX and goodY:
		onScreen = true;
	return onScreen;
