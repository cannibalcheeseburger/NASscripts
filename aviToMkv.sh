#!/bin/bash
mkdir converted
FILES=( "./"*.AVI)
for FILE in "${FILES[@]}"
do
ffmpeg -i "$FILE" ./converted/"${FILE%.*}".mp4
done
## Convert files
#ffmpeg -i kash.DAT -c:v libx264 -crf 20 -c:a aac -b:a 128k -movflags +faststart kash.mp4
