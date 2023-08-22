#!/bin/bash

# conf=("/etc/fstab" "/etc/samba/smb.conf")
readarray -t conf <  ./conf.txt
for con in  "${conf[@]}"
do
  cp -f $con ./
done
