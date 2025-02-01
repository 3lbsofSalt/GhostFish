extends Node2D

@onready var SHIP_DIMENSION = 7
@onready var FRAME_WIDTH = get_viewport().get_visible_rect().size.x;
@onready var FRAME_HEIGHT = get_viewport().get_visible_rect().size.y;

# Called when the node enters the scene tree for the first time.

@onready var threePearlsFound = false

@onready var roomSceneEmpty = preload("res://scenes/rooms/ship_empty.tscn");
@onready var roomScenePlus = preload("res://scenes/rooms/ship_plus.tscn");
@onready var roomSceneScattered = preload("res://scenes/rooms/ship_scattered.tscn");
@onready var roomSceneZigZagUp = preload("res://scenes/rooms/ship_zig_zag_up.tscn");
@onready var roomSceneZigZagSide = preload("res://scenes/rooms/ship_zig_zag_side.tscn");
@onready var roomSceneDivideUpRight = preload("res://scenes/rooms/ship_divide_up_right.tscn");
@onready var roomSceneDivideDownRight = preload("res://scenes/rooms/ship_divide_down_right.tscn");
@onready var roomSceneBoss = preload("res://scenes/rooms/boss_room.tscn");
@onready var roomScenePearl = preload("res://scenes/rooms/pearl_room.tscn");

# ROOM CODES:
# 0 = empty room
# 1 = plus room
# 2 = scattered room
# 3 = zig zag up
# 4 = zig zag side
# 5 = divide up right
# 6 = divide down right
# 7 = boss
# 8 = pearl room

var roomList = [1, 1, 2, 2, 3, 3, 4,
				4, 4, 3, 3, 4, 1, 1,
				3, 2, 2, 2, 2, 1, 1,
				3, 0, 1, 0, 8, 8, 8,
				3, 0, 1, 2, 0, 2, 0,
				3, 0, 0, 7, 0, 0, 5,
				4, 4, 4, 4, 2, 1, 3];

func _ready() -> void:
	roomList.shuffle()
	print(roomList)
	
	for row in range(SHIP_DIMENSION):
		for col in range(SHIP_DIMENSION):
			var roomIndexToAdd = roomList[convertTwoDimsToOne(row, col)]
			if roomIndexToAdd == 7:
				print(row,col)
			var roomToAdd = getRoomFromIndex(roomIndexToAdd)
			var roomInstance = roomToAdd.instantiate();
				
			roomInstance.position = getPosToBuildNextRoom(row, col)
			add_child(roomInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func convertTwoDimsToOne(row, col):
	return SHIP_DIMENSION * row + col
	
func getPosToBuildNextRoom(row, col):
	return Vector2(FRAME_WIDTH * col, FRAME_HEIGHT * row)
	
func getRoomFromIndex(roomIndexToAdd):
	var roomToReturn;
	match roomIndexToAdd:
		0:
			roomToReturn = roomSceneEmpty
		1:
			roomToReturn = roomScenePlus
		2:
			roomToReturn = roomSceneScattered
		3:
			roomToReturn = roomSceneZigZagUp
		4:
			roomToReturn = roomSceneZigZagSide
		5:
			roomToReturn = roomSceneDivideUpRight
		6:
			roomToReturn = roomSceneDivideDownRight
		7:
			roomToReturn = roomSceneBoss
		8:
			roomToReturn = roomScenePearl
	return roomToReturn;
