echo "/hddmain/photoarchive/"
for i in */ /hddmain/photoarchive/* ; do 
    echo -n $i": " ; 
    (find "$i" -type f | wc -l) ; 
done


echo "/hdd/photoarchive/"
for i in */ /hdd/photoarchive/* ; do 
    echo -n $i": " ; 
    (find "$i" -type f | wc -l) ; 
done

