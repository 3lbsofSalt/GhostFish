extends CharacterBody2D


const SPEED = 400.0

@onready var playerSprite = $PlayerSprite;
var alive = true;

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction *  SPEED
	if (velocity.x != 0 or velocity.y != 0):
		playerSprite.play("run")
		if (velocity.x > 0):
			playerSprite.flip_h = false;
		else:
			playerSprite.flip_h = true;
	elif (velocity.x == 0 and velocity.y == 0):
		playerSprite.play("default")
		
func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func getPosition():
	return position;

func take_damage():
	die();

func die():
	alive = false;
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			print("SHOOT BUBBLE")
