# Media Manipulation

Doing bad stuff with media files.

## Scripts

### - [deleteDupes.sh](./deleteDupes.sh)

Gives option to handle duplicate files in /hdd/photoarchive

### - [dumpBinning.sh](./dumpBinning.sh)

Bins the `DUMP` folders in photoarchive based on month.

### - [getStatMoveYear](./getStatMoveYear.sh)

Uses Exiftool to get modified date metadata from files and moves the files to `$Year` folder.

### - [iphone.sh](./iphone.sh)

Makes folder named `iphone` and moves all `.heic` files to the folder.

### - [moveDate.sh](./moveDate.sh)

Takes 2 console arguments 
 - `Date`: in format MMDD
 - `FolderName`: Name of the folder you want to create

 Moves all the files from `Date` to the folder `FolderName`. 

### - [moveVideos.sh](./moveVideos.sh)

Moves all the videos in the folder to the folder `videos` (Auto-created).

Formats included:
 - `.AVI`
 - `.THM`
 - `.MOV`
 - `.avi`
 - `.MP4`
 - `.mpeg`

### - [moveYear.sh](./moveYear.sh)

Takes console argument `$Year` and moves all images and videos from that year to the folder named `$Year`

Regex used:
 - "./$1"*
 - "./P_$1"*
 - "./IMG-$1"*
 - "./IMG$1"*
 - "./IMG_$1"*
 - "./VID_$1"*

### - [renameDouble.sh](./renameDouble.sh)

IDK WTF this does. (Need to be figured out)

### - [renameDSC.sh](./renameDSC.sh)

Uses Exiftool to get modified date and renames all files starting with `DSC_` to the TimeStamp of the file. 

Format :
```
"%Y%m%d_%H%M%S%%-c.%%e"
```

### - [renameSnap.sh](./renameSnap.sh)

Uses Exiftool to get modified date and renames all files starting with `Snapchat-` to the TimeStamp of the file. 

Format :
```
"%Y%m%d_%H%M%S%%-c.%%e"
```


