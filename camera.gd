extends Camera2D

@onready var SCREEN_WIDTH = get_viewport().get_visible_rect().size.x;
@onready var SCREEN_HEIGHT = get_viewport().get_visible_rect().size.y;
const PAN_TIME = 0.25;

var current_frame_num = Vector2(0,0)

@onready var playerPosition;
@onready var playerFish = get_tree().current_scene.get_node("PlayerBody2D");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func player_in_ship() -> bool:
	if current_frame_num.x < 0 or current_frame_num.x > 6:
		return false;
	elif current_frame_num.y < 0 or current_frame_num.y > 6:
		return false;
	else:
		return true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerPosition = playerFish.getPosition();
	var new_frame_num = Vector2(int(playerPosition.x / SCREEN_WIDTH), int(playerPosition.y / SCREEN_HEIGHT))
	if (new_frame_num != current_frame_num):
		current_frame_num = new_frame_num;
		var panTween = create_tween();
		var newPosition = Vector2(SCREEN_WIDTH * new_frame_num.x, SCREEN_HEIGHT * new_frame_num.y)
		panTween.tween_property(self, "position", newPosition, PAN_TIME)
