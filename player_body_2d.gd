extends CharacterBody2D

@export var speed = 600.0;

@export var bubble_start_size = 0.01;
@export var bubble_growth_rate = 0.01;
const SPEED = 600.0

@onready var playerSprite = $PlayerSprite;
@onready var bubble: AnimatedSprite2D = %Bubble;

var alive = true;
var blowing_bubble = false;
var bubble_size = 100;

func get_input():
	if not GameState.is_running():
		velocity.x = 0;
		velocity.y = 0;
		return;

	if MouthDetection.mouth_open:
		blowing_bubble = true;
		bubble.visible = true;
		playerSprite.play('open')
		bubble.visible = true;
	else:
		blowing_bubble = false;
		bubble.visible = false;
		playerSprite.play('closed')
		bubble.visible = false;

	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction *  speed;
	if (velocity.x != 0 or velocity.y != 0):
		if (velocity.x > 0):
			playerSprite.flip_h = false;
		else:
			playerSprite.flip_h = true;

		
func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func getPosition():
	return position;

func take_damage():
	print('did the thing...')
	die();

func is_alive() -> bool:
	return alive;

func die():
	alive = false;
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			print("SHOOT BUBBLE")
