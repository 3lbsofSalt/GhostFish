extends Sprite2D

var boss_spawned = false;
var butler_scene = preload("res://scenes/LungeGuy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.pearls_collected >= 3 and not boss_spawned:
		var obj = butler_scene.instantiate()
		obj.position = Vector2(550, 350)
		add_child(obj)
		boss_spawned = true
		print("boss spawned ")
