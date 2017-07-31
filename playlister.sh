#!/bin/bash

LINKS_FILE=$1
DOWNLOADS_PATH=$(dirname "$1")

echo "----------------------------"
echo "Usage: playlister <LINKS FILE>"
echo "----------------------------"

echo "Reading videos from: $LINKS_FILE"
echo "Your downloaded files will be available here: $DOWNLOADS_PATH"

echo ''

youtube-dl -o "$DOWNLOADS_PATH/%(title)s.%(ext)s" --batch-file "$LINKS_FILE"

# while read -r url; do
#   echo "youtube-dl -o \"$DOWNLOADS_PATH/%(title)s.%(ext)s\" $url"
#   echo 'Download completed'
# done < "$LINKS_FILE"
