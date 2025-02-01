# #!/home/isaacp/repos/GhostFish/env/bin/python3
# import os
# import sys
# import subprocess
# import venv
# from pathlib import Path

# # List of required packages
# REQUIRED_PACKAGES = ["numpy", "pandas", "mediapipe"]  # Modify as needed
# VENV_DIR = "env"  # Change this if you want a different venv name

# def create_virtualenv():
# 	"""Create a virtual environment and install required packages."""
# 	print(f"Creating virtual environment in {VENV_DIR}...")
# 	venv.create(VENV_DIR, with_pip=True)

# 	python_executable = os.path.join(VENV_DIR, "bin", "python") if os.name != "nt" else os.path.join(VENV_DIR, "Scripts", "python.exe")

# 	print("Installing required packages...")
# 	subprocess.check_call([python_executable, "-m", "pip", "install", "--upgrade", "pip"])
# 	subprocess.check_call([python_executable, "-m", "pip", "install"] + REQUIRED_PACKAGES)

# 	python_executable = os.path.join(VENV_DIR, "bin", "python") if os.name != "nt" else os.path.join(VENV_DIR, "Scripts", "python.exe")	
# 	subprocess.run([python_executable, "./mouth_detection.py"])
# 	sys.exit()

# def run_in_venv():
# 	"""Restart script inside the virtual environment."""
# 	python_executable = os.path.join(VENV_DIR, "bin", "python") if os.name != "nt" else os.path.join(VENV_DIR, "Scripts", "python.exe")

# 	print(f"Restarting script inside virtual environment ({VENV_DIR})...")
# 	subprocess.check_call([python_executable, *sys.argv])
# 	sys.exit()  # Exit original script after restarting

# if not Path(VENV_DIR).exists():
# 	create_virtualenv()
# 	run_in_venv()

# try:
# 	import cv2
# 	import mediapipe as mp
# 	import numpy as np
# except:
# 	# Step 4: Main script logic (runs inside venv)
# 	print("Running script with all dependencies installed!")
# 	python_executable = os.path.join(VENV_DIR, "bin", "python") if os.name != "nt" else os.path.join(VENV_DIR, "Scripts", "python.exe")	
# 	subprocess.run([python_executable, "./mouth_detection.py"])
# 	sys.exit()

import cv2
import mediapipe as mp
import numpy as np

# Initialize Mediapipe Face Mesh
mp_face_mesh = mp.solutions.face_mesh
face_mesh = mp_face_mesh.FaceMesh(static_image_mode=False, max_num_faces=1, refine_landmarks=True)
mp_drawing = mp.solutions.drawing_utils

# Define mouth landmarks
MOUTH_LANDMARKS = [13, 14]  # Upper and lower lip midpoints

# Start webcam
cap = cv2.VideoCapture(0)

while cap.isOpened():
	ret, frame = cap.read()
	if not ret:
		break

	# Convert frame to RGB
	rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

	# Process the frame with Mediapipe
	results = face_mesh.process(rgb_frame)

	if results.multi_face_landmarks:
		for face_landmarks in results.multi_face_landmarks:
			# Get mouth landmarks
			upper_lip = np.array([face_landmarks.landmark[MOUTH_LANDMARKS[0]].x,
								  face_landmarks.landmark[MOUTH_LANDMARKS[0]].y])
			lower_lip = np.array([face_landmarks.landmark[MOUTH_LANDMARKS[1]].x,
								  face_landmarks.landmark[MOUTH_LANDMARKS[1]].y])

			# Calculate mouth opening distance
			height, width, _ = frame.shape
			upper_lip_px = np.array([upper_lip[0] * width, upper_lip[1] * height])
			lower_lip_px = np.array([lower_lip[0] * width, lower_lip[1] * height])
			mouth_open_distance = np.linalg.norm(upper_lip_px - lower_lip_px)
			
			with open('./mouth_open.txt','w') as f:
				if mouth_open_distance > 10:
					f.write('yes')
				else:
					f.write('no')

	if cv2.waitKey(1) & 0xFF == ord('q'):
		break

cap.release()
cv2.destroyAllWindows()
