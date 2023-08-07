#!/bin/bash

monthnames=("invalid" "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
for mon in $(seq 1 12);
do
	i=$(printf '%02d' $mon)
	mkdir -p "${monthnames[mon]}"
	FILES=( "./IMG_"????"$i"*)
	for FILE in "${FILES[@]}";do
		mv "$FILE" ./"${monthnames[mon]}"/
	done
done

