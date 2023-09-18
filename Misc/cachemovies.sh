
#!/bin/bash
# No of movies to include
MOVIEFOLDER="/hddmain/media/movies/"
NOMOVIES=2; #+1 number
#Finds path of all the movies changed last 10 days
#readarray -t movies < <(find /hddmain/media/movies/ -type d -ctime -10 -ls | grep -o '/hddmain.*' | tail -n +2  | tr -d '\')
readarray -t movies < <(ls -t /hddmain/media/movies)
COUNT=0;
for movie in "${movies[@]}"
do
  if [[ $COUNTER -gt $NOMOVIES ]] ; then
    exit 1;
  fi
 # echo $MOVIEFOLDER"$movie"  
  rm -rf /hdd/devicesync/cached/*;
  cp -frv $MOVIEFOLDER"$movie" "/hdd/devicesync/cached";
  COUNTER=$[$COUNTER +1]
done
