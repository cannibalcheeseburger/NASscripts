#!/bin/bash
FOL="2012"
mkdir -p "$FOL"
FILES=( "./"*.JPG)
for FILE in "${FILES[@]}";do
YEAR=$( stat --printf='%y\n' "$FILE" | cut -c 1-4 )
if [ "$YEAR" == "$FOL" ] 
then
mv "$FILE" ./"$FOL"
fi
done
