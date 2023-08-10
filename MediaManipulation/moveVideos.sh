#!/bin/bash
mkdir -p videos
FILES=( "./"*.AVI)
FILES+=( "./"*.THM)
FILES+=( "./"*.mp4)
FILES+=( "./"*.MOV)
FILES+=( "./"*.avi)
FILES+=( "./"*.MP4)
FILES+=( "./"*.mpeg)
for FILE in "${FILES[@]}";do
mv "$FILE" ./videos/
done
## Convert files
#ffmpeg -i kash.DAT -c:v libx264 -crf 20 -c:a aac -b:a 128k -movflags +faststart kash.mp4
