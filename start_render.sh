#!/bin/bash

# Check argument count
if [ $# -ne 2 ]; then
    echo "Invalid hostname."
    echo "Type 'bash $0 hostname file.blend'"
    exit 1
fi


HOST=$1
BLEND_FILE=$2
ZIP_FILE="$BLEND_FILE.zip"
PEM_FILE="YOUR_PEM_FILE"
TMP_DIR="render_$(date +%s)"

# Create temporary folder
echo "Creating $TMP_DIR directory..."
ssh -i $PEM_FILE ubuntu@$HOST mkdir $TMP_DIR
echo "Creating $TMP_DIR directory...done"
echo

# Zip
echo "Compressing $BLEND_FILE..."
zip $ZIP_FILE $BLEND_FILE
echo "Compressing $BLEND_FILE...done"
echo

# Upload blend file
echo "Uploading $BLEND_FILE..."
scp -i $PEM_FILE $ZIP_FILE ubuntu@$HOST:/home/ubuntu/$TMP_DIR
echo "Uploading $BLEND_FILE...done"
echo

# Unzip
echo "Decompressing $BLEND_FILE..."
ssh -i $PEM_FILE ubuntu@$HOST unzip /home/ubuntu/$TMP_DIR/$ZIP_FILE -d /home/ubuntu/$TMP_DIR/
echo "Decompressing $BLEND_FILE...done"
echo

# Start Render
echo "Starting render..."
ssh -i $PEM_FILE ubuntu@$HOST blender -b /home/ubuntu/$TMP_DIR/$BLEND_FILE -o /home/ubuntu/$TMP_DIR/output -F JPEG -x 1 -f 1
echo "Done!"
echo

# Download render
echo "Downloading render..."
scp -i $PEM_FILE ubuntu@$HOST:/home/ubuntu/$TMP_DIR/output0001.jpg .
echo "Downloading render...done"

# Delete temporary folder
echo "Deleting $TMP_DIR directory..."
ssh -i $PEM_FILE ubuntu@$HOST rm -rf $TMP_DIR
echo "Deleting $TMP_DIR directory...done"

echo "Congratulation, your render is output0001.jpeg !!!"
