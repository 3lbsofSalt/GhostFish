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


    #         # Display result
    #         cv2.putText(frame, f"Mouth Open: {'Yes' if mouth_open_distance > 10 else 'No'}",
    #                     (30, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

    # # Display the frame
    # cv2.imshow('Mouth Open Detection', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
