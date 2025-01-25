extends CharacterBody2D;
@export var bubble_size_damage_factor: float = (1000/8);
@export var min_speed: float = 100;
@export var bubble_slow_down_factor: float = 20;
@export var initial_speed: float = 600;
@export var speed: float = 600.0;
@export var bubble_start_size: Vector2 = Vector2(0.01, 0.01);
@export var bubble_growth_rate: Vector2 = Vector2(0.0005, 0.0005);
@export var bubble_offset: Vector2 = Vector2(1, -1);
@export var health: float = 10.0;
@export var max_health: float = 10.0;
@export var pearl_health_recovery: float = 5;
var can_take_damage = true;
var max_damage_timer = 2000;
var damage_timer = 2000;


@onready var playerSprite = $PlayerSprite;
@onready var bubble: AnimatedSprite2D = %Bubble;
@onready var bubbleArea: Area2D = %BubbleArea;

signal bubblePopSig();
signal bubbleGrowSig();

var alive = true;
var blowing_bubble = false;
var bubble_size = 100;

var bubbleGrowSoundPlaying = false;

func get_input():
	if not GameState.is_running():
		velocity.x = 0; velocity.y = 0;
		return;

	if MouthDetection.mouth_open:
		playerSprite.play('open')
		blowing_bubble = true;
		bubble.visible = true;
		if not bubbleGrowSoundPlaying:
			emit_signal("bubbleGrowSig");
			bubbleGrowSoundPlaying = true;

	else:
		bubble.visible = false;
		playerSprite.play('closed')
		if blowing_bubble: # Bubble gets popped
			emit_signal("bubblePopSig");
			blowing_bubble = false;
			bubbleGrowSoundPlaying = false;
			#bubble.scale = bubble_start_size;
			# Reset Bubble Position
			if playerSprite.flip_h:
				bubble.position = Vector2(-34, 2);
			else:
				bubble.position = Vector2(34, 2);
			# Handle Collisions
			for collision in bubbleArea.get_overlapping_areas():
				if collision.is_in_group('Ghost') and collision.has_method('take_damage'):
					collision.take_damage(bubble.scale[0]*self.bubble_size_damage_factor);
					
			bubble.scale = bubble_start_size;
			self.speed = self.initial_speed
			



	# Calculate Fish Direction
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed;
	if (velocity.x != 0 or velocity.y != 0):
		if (velocity.x > 0):
			if playerSprite.flip_h:
				bubble.position.x = -bubble.position.x;
			playerSprite.flip_h = false;
		else:
			if not playerSprite.flip_h:
				bubble.position.x = -bubble.position.x;
			playerSprite.flip_h = true;

func _process(_delta: float) -> void:
	if not self.can_take_damage:
		self.damage_timer -= _delta;
		if self.damage_timer <= 0:
			self.can_take_damage = true
			self.damage_timer = self.max_damage_timer
	if health <= 0:
		die();

func _physics_process(_delta):
	get_input()
	if blowing_bubble:
		if playerSprite.flip_h:
			bubble.position.y += bubble_offset.y;
			bubble.position.x -= bubble_offset.x;
		else:
			bubble.position += bubble_offset;
		bubble.scale = bubble.scale + bubble_growth_rate;
		self.speed =  max(self.speed - (bubble.scale[0] * self.bubble_slow_down_factor), self.min_speed) 

	move_and_slide()
	
func getPosition():
	return position;

func take_damage(amount = 1):
	if self.can_take_damage:
		modulate = Color(1, .5, .5, 1);
		var hitTween = create_tween();
		hitTween.parallel().tween_property(self, "modulate", Color(1, 1, 1, 1), .25);
		$PlayerSprite/TakeDamage.play();
		
		health -= amount
		health = clamp(health, 0, max_health)
		self.can_take_damage = false

func is_alive() -> bool:
	return alive;

func die():
	alive = false;
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			print("SHOOT BUBBLE")

func _on_progress_bar_value_changed(value: float) -> void:
	pass # Replace with function body.
