#!/bin/bash
FILES=( "./DSC_"* )
for FILE in "${FILES[@]}";do
exiftool '-FileName<filemodifydate' -d "%Y%m%d_%H%M%S%%-c.%%e" "$FILE"
done
