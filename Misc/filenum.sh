for i in */ /hdd/photoarchive/* ; do 
    echo -n $i": " ; 
    (find "$i" -type f | wc -l) ; 
done
