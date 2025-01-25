extends CharacterBody2D


const SPEED = 300.0

@onready var playerSprite = $CollisionShape2D/PlayerSprite;

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
		
func _physics_process(delta):
	get_input()
	move_and_slide()
	
func getPosition():
	return position;
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			print("SHOOT BUBBLE")
