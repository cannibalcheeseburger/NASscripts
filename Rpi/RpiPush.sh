#!/bin/bash

# conf=("/etc/fstab" "/etc/samba/smb.conf")
readarray -t conf <  ./conf.txt
for con in  "${conf[@]}"
do
  cd $con
  git add .
  git commit -m "$(date +%s)"
  git push -u origin master
done
