find /hdd/photoarchive/2013-2016/2016/ -type f -name "IMG-*" > log.txt
#exiftool "-filemodifydate<datetimeoriginal"
#exiftool -overwrite_original '-filemodifydate<FileName' -'datetimeoriginal<FileName' ./
