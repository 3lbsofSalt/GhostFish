extends Sprite2D

@onready var boss_spawned = false

@onready var SCREEN_WIDTH = get_viewport().get_visible_rect().size.x;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.pearls_collected >= 3 and not boss_spawned:
		boss_spawned = true
		var panTween = create_tween();
		panTween.tween_property(self, "position", Vector2(SCREEN_WIDTH / 2, position.y), .5) # come from left
		panTween.tween_property(self, "position", Vector2(SCREEN_WIDTH / 2, position.y), 1) # wait one second
		panTween.tween_property(self, "position", Vector2(2000, position.y), .5) # leave to right
