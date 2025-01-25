extends GridContainer

# -1 Undiscovered,
# 0 Discovered (generic room)
# 4 Player Position
# 7 Pearl Room
# 8 Boss Room
const color_by_type = { 
	-2: '#1E88E5',
	-1: 'e0e0e0',
	0: '#a1a1a1', 
	7: '#F44336',
	8: '#8BC34A',
}
var map_discovered = [-1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1, 
					  -1, -1, -1, -1, -1, -1, -1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for i in range(0, len(map_discovered)):
		if map_discovered[i] == -2:
			print(%Map.roomList[i]);
			if %Map.roomList[i] == 8:
				map_discovered[i] = 8;
			elif %Map.roomList[i] == 7:
				map_discovered[i] = 7;
			else:
				map_discovered[i] = 0;

		var playerPosition: Vector2 = %Camera.current_frame_num;
		var square = playerPosition.y * 7 + playerPosition.x;
		if square < 49:
			map_discovered[square] = -2;
		colorMap();

func colorMap() -> void:
	var rectangles = find_children("*", "ColorRect");
	for i in range(0, len(map_discovered)):
		rectangles[i].color = color_by_type[map_discovered[i]];
