#!/bin/bash

# Define the path to your virtual environment
ENV_DIR="./env"

# Check if the virtual environment directory exists
if [ ! -d "$ENV_DIR" ]; then
  echo "Virtual environment not found. Creating a new one..."

  # Create a virtual environment
  python3 -m venv $ENV_DIR
  
  # Activate the virtual environment
  source $ENV_DIR/bin/activate

  # Install the packages from requirements.txt
  if [ -f "requirements.txt" ]; then
    echo "Installing packages from requirements.txt..."
    pip install -r requirements.txt
  else
    echo "requirements.txt file not found. Skipping package installation."
  fi
  
  echo "Virtual environment setup completed."
else
  echo "Virtual environment already exists. Skipping creation."
  
  # Activate the existing virtual environment
  source $ENV_DIR/bin/activate
fi
