#!/bin/bash
set -euo pipefail

# Directory configuration
FLUTTER_SDK_INSTALL_DIR="$HOME/flutter"
BASHRC_FILE="$HOME/.bashrc"
PROJECT_DIR="/workspace/scoopify-manager"

# Function to install packages on Debian/Ubuntu
install_dependencies() {
  sudo apt update
  sudo apt install -y \
    curl git unzip xz-utils zip libglu1-mesa default-jdk
}

# 1. Install system dependencies
if ! command -v git &>/dev/null; then
  echo "git is not installed. Installing system dependencies..."
  install_dependencies
fi

# 2. Clone or update Flutter
if [ ! -d "$FLUTTER_SDK_INSTALL_DIR" ]; then
  echo "Cloning Flutter into $FLUTTER_SDK_INSTALL_DIR..."
  git clone https://github.com/flutter/flutter.git -b stable "$FLUTTER_SDK_INSTALL_DIR"
fi
cd "$FLUTTER_SDK_INSTALL_DIR"

echo "Fetching tags and switching to tag 3.29.3..."
git fetch --tags
git checkout 3.29.3

# 3. Add Flutter to PATH
FLUTTER_PATH_EXPORT_LINE="export PATH=\"$FLUTTER_SDK_INSTALL_DIR/bin:\$PATH\""
if ! grep -Fxq "$FLUTTER_PATH_EXPORT_LINE" "$BASHRC_FILE"; then
  echo "Adding Flutter to PATH in $BASHRC_FILE..."
  echo "$FLUTTER_PATH_EXPORT_LINE" >> "$BASHRC_FILE"
fi
export PATH="$FLUTTER_SDK_INSTALL_DIR/bin:$PATH"

# 4. Run flutter doctor and accept Android licenses if needed
echo "Running flutter doctor..."
flutter doctor

echo "Automatically accepting Android licenses if required..."
yes "y" | flutter doctor --android-licenses || true

# 5. Flutter precache
echo "Running flutter precache..."
flutter precache

# 6. Check if project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: project directory $PROJECT_DIR does not exist."
  exit 1
fi

# 7. Prepare the Flutter project
echo "Entering project directory $PROJECT_DIR..."
cd "$PROJECT_DIR"

echo "Running flutter pub get..."
flutter pub get

echo "Setup completed successfully!"
