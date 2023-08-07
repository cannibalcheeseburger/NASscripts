#!/bin/bash
mkdir -p "$1"
FILES=( "./$1"*)
FILES+=( "./P_$1"*)
FILES+=( "./IMG-$1"*)
FILES+=( "./IMG$1"*)
FILES+=( "./IMG_$1"*)
FILES+=( "./VID_$1"*)
for FILE in "${FILES[@]}";do
mv "$FILE" ./"$1"/
done
