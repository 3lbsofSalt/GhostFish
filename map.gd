extends Node2D

@onready var SHIP_DIMENSION = 7
@onready var FRAME_WIDTH = 1152
@onready var FRAME_HEIGHT = 648

# Called when the node enters the scene tree for the first time.

@onready var roomSceneEmpty = preload("res://scenes/ship_empty.tscn");
@onready var roomScenePlus = preload("res://scenes/ship_plus.tscn");
@onready var roomSceneScattered = preload("res://scenes/ship_scattered.tscn");
@onready var roomSceneZigZagUp = preload("res://scenes/ship_zig_zag_up.tscn");
@onready var roomSceneZigZagSide = preload("res://scenes/ship_zig_zag_side.tscn");
@onready var roomSceneDivideUpRight = preload("res://scenes/ship_divide_up_right.tscn");
@onready var roomSceneDivideDownRight = preload("res://scenes/ship_divide_down_right.tscn");

# ROOM CODES:
# 0 = empty room
# 1 = plus room
# 2 = scattered room
# 3 = zig zag up
# 4 = zig zag side
# 5 = divide up right
# 6 = divide down right

func _ready() -> void:
	var roomList = [1, 1, 2, 2, 3, 3, 4,
					4, 5, 5, 6, 6, 1, 1,
					3, 2, 2, 2, 2, 1, 1,
					3, 0, 0, 0, 0, 0, 0,
					3, 0, 0, 6, 6, 6, 6,
					3, 0, 0, 0, 0, 0, 5,
					4, 4, 4, 4, 5, 5, 5]
	roomList.shuffle()
	print(roomList)
	
	#var bleh = convertTwoDimsToOne(0, 0)
	#print(bleh)
	#var testRoom = getRoomFromIndex(bleh)
	
	for row in range(SHIP_DIMENSION):
		for col in range(SHIP_DIMENSION):
			print(row, col)
			var roomIndexToAdd = roomList[convertTwoDimsToOne(row, col)]
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
			print("ZERO")
		1:
			roomToReturn = roomScenePlus
			print("ONE")
		2:
			roomToReturn = roomSceneScattered
			print("TWO")
		3:
			roomToReturn = roomSceneZigZagUp
			print("THREE")
		4:
			roomToReturn = roomSceneZigZagSide
			print("FOUR")
		5:
			roomToReturn = roomSceneDivideUpRight
			print("FIVE")
		6:
			roomToReturn = roomSceneDivideDownRight
			print("SIX")
	return roomToReturn;
