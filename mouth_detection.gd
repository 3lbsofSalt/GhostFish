extends Node

var python_process_id = null
var mouth_state_file_path = "res://mouth_open.txt"  # Adjust path if needed
var mouth_open = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	# setup the python env if it doesnt exist
	#python_process_id = OS.execute("./setup.sh", [""])
	# Run the Python script
	print(OS.get_name())
	if OS.get_name() == 'X11' or OS.get_name() == 'Linux':
		python_process_id = OS.execute("env/bin/python", ["mouth_detection.py"])
	else:
		python_process_id = OS.execute("env\\Scripts\\python.exe", ["mouth_detection.py"])
	print("Python script started with process ID: ", python_process_id, OS.get_name())

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
	print(file)
	if file:
		var mouth_state = file.get_as_text()
		print(mouth_state)
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
