#!/bin/bash
mkdir -p "iphone"
FILES=( "./"*.heic)
for FILE in "${FILES[@]}";do
mv "$FILE" ./iphone/
done
