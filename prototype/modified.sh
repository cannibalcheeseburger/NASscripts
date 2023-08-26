#find /hdd/photoarchive/ -type f -name "IMG*" > log.txt
#exiftool "-filemodifydate<datetimeoriginal"
exiftool -overwrite_original '-filemodifydate<FileName' -'datetimeoriginal<FileName' ./
