#!/bin/bash
mkdir converted
FILES=( "./"*.mp4)
for FILE in "${FILES[@]}"
do
ffmpeg -i "$FILE" -map_metadata 0 ./converted/"${FILE%.*}".mp4
exiftool -overwrite_original '-filemodifydate<FileName' -'datetimeoriginal<FileName' ./converted/"${FILE%.*}".mp4
done
## Convert files
#ffmpeg -i kash.DAT -c:v libx264 -crf 20 -c:a aac -b:a 128k -movflags +faststart kash.mp4
