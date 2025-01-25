extends Sprite2D

@onready var boss_spawned = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.pearls_collected >= 3 and not boss_spawned:
		boss_spawned = true
		var panTween = create_tween();
		panTween.tween_property(self, "position", Vector2(576, position.y), .5)
		panTween.tween_property(self, "position", Vector2(576, position.y), 1)
		panTween.tween_property(self, "position", Vector2(2000, position.y), .5)
