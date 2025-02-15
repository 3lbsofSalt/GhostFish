extends Node

var python_process_id = null
var mouth_state_file_path = "res://mouth_open.txt"  # Adjust path if needed
var mouth_open = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	# setup the python env if it doesnt exist
	#python_process_id = OS.execute("./setup.sh", [""])
	# Run the Python script
	var file = FileAccess.open(mouth_state_file_path, FileAccess.WRITE)
	file.store_string("")
	
	print(OS.get_name())
	python_process_id = OS.execute("python", ["mouth_detection.py"])
	print("Python script started with process ID: ", python_process_id, OS.get_name())
	
	file = FileAccess.open(mouth_state_file_path, FileAccess.READ)
	while file.get_as_text() == "":
		file = FileAccess.open(mouth_state_file_path, FileAccess.READ)
		
	# Start checking the file for updates
	set_process(true)

func _process(delta):
	# Read the mouth state from the file
	var file = FileAccess.open(mouth_state_file_path, FileAccess.READ)
	if file:
		var mouth_state = file.get_as_text()
		file.close()

		# Example: Use mouth state in the game
		if mouth_state == "yes":
			mouth_open = true;
		elif mouth_state == "no":
			mouth_open = false;

func _exit_tree():
	if python_process_id != null:
		OS.kill(python_process_id)
		print("Python process terminated")
	# Create an instance of the File class
	var file = FileAccess.open(mouth_state_file_path, FileAccess.READ)
	if file:
		DirAccess.remove_absolute(file.get_path_absolute())
		
		
	
