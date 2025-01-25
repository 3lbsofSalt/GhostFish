extends Node

var python_process_id = null
var mouth_state_file_path = "res://mouth_open.txt"  # Adjust path if needed
# Called when the node enters the scene tree for the first time.
func _ready():
	# Run the Python script
	python_process_id = OS.execute("/home/isaacp/repos/GhostFish/ghostfishenv/bin/python", ["mouth_detection.py"])
	print("Python script started with process ID: ", python_process_id)

	# Check if the file exists
	if !FileAccess.file_exists(mouth_state_file_path):
		var file = FileAccess.open(mouth_state_file_path, FileAccess.WRITE)
		file.store_string("closed")
		file.close()
	

	# Start checking the file for updates
	set_process(true)

func _process(delta):
	# Read the mouth state from the file
	var file = FileAccess.open(mouth_state_file_path, FileAccess.READ)
	if file:
		var mouth_state = file.get_as_text()
		file.close()

		# Example: Use mouth state in the game
		if mouth_state == "open":
			print("Mouth is open")
			get_node("Player").perform_mouth_open_action()
		elif mouth_state == "closed":
			print("Mouth is closed")

func _exit_tree():
	if python_process_id != null:
		OS.kill(python_process_id)
		print("Python process terminated")
