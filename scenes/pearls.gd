extends AnimatedSprite2D

@onready var collected = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# update sore
	# change animation
	if body.is_in_group('Fish') and not collected:
		collected = true;
		body.health = min(body.max_health, body.health + body.pearl_health_recovery)
		self.play('collected')
		if GameState.is_running():
			GameState.score += 200;
			GameState.pearls_collected += 1;
		$GetPearl.play();
