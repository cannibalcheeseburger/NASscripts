#!/bin/bash
mkdir -p $1
FILES=( "./"*.jpg)
for FILE in "${FILES[@]}";do
YEAR=$( stat --printf='%y\n' "$FILE" | cut -c 1-4 )
if [ "$YEAR" == "$1" ] 
then
mv $FILE ./$1
fi
done
