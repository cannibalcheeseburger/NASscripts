#sudo /mnt/archive/kashshare/scripts/configbackup.sh

# # # # # # # # # # # # # # # #
# USER CONFIGURABLE VARIABLES #
# # # # # # # # # # # # # # # #


# Server IP or URL (include http(s)://)
serverURL="http://192.168.29.196"

# TrueNAS API key (Generate from 'User Icon' -> 'API Keys' in TrueNAS WebGUI)
apiKey="1-egih2G1z8Vlacdsy0z7M2qbWlq18d7OSB1cBhR0a2rgjmcP5OFbl0wdWMzdLwvHS"

# Include Secret Seed (true| false)
secSeed=true

# Path on server to store backups
backuploc="/mnt/archive/kashshare/backup/"

# Max number of backups to keep (set as 0 to never delete anything)
maxnrOfFiles=5


# # # # # # # # # # # # # # # # # #
# END USER CONFIGURABLE VARIABLES #
# # # # # # # # # # # # # # # # # #


echo
echo "Backing up current TrueNAS config"

# Check current TrueNAS version number
versiondir=`cat /etc/version | cut -d' ' -f1`

# Set directory for backups to: 'path on server' / 'current version number'
backupMainDir="${backuploc}/${versiondir}"

# Create directory for for backups (Location/Version)
mkdir -p $backupMainDir


# Use appropriate extention if we are exporting the secret seed
if [ $secSeed = true ]
then
    fileExt="tar"
    echo "Secret Seed will be included"
else
    fileExt="db"
    echo "Secret Seed will NOT be included"
fi
    
# Generate file name
fileName=$(hostname)-TrueNAS-$(date +%Y%m%d%H%M%S).$fileExt


# API call to backup config and include secret seed
curl --no-progress-meter \
-X 'POST' \
$serverURL'/api/v2.0/config/save' \
-H 'Authorization: Bearer '$apiKey \
-H 'accept: */*' \
-H 'Content-Type: application/json' \
-d '{"secretseed": '$secSeed'}' \
--output $backupMainDir/$fileName

echo
echo "Config saved to ${backupMainDir}/${fileName}"

#
# The next section checks for and deletes old backups
#
# Will not run if $maxnrOfFiles is set to zero (0)
#

if [ ${maxnrOfFiles} -ne 0 ]
then
    echo
    echo "Checking for old backups to delete"
    echo "Number of files to keep: ${maxnrOfFiles}"

    # Get number of files in the backup directory
    nrOfFiles="$(ls -l ${backupMainDir} | grep -c "^-.*")"

    echo "Current number of files: ${nrOfFiles}"

    # Only do something if the current number of files is greater than $maxnrOfFiles
     if [ ${maxnrOfFiles} -lt ${nrOfFiles} ]
     then
         nFileToRemove="$((nrOfFiles - maxnrOfFiles))"
         echo "Removing ${nFileToRemove} file(s)"
          while [ $nFileToRemove -gt 0 ]
          do
             fileToRemove="$(ls -t ${backupMainDir} | tail -1)"
             echo "Removing file ${fileToRemove}"
             nFileToRemove="$((nFileToRemove - 1))"
             rm ${backupMainDir}/${fileToRemove}
             done
         fi
# Inform the user that no files will be deleded if $maxnrOfFiles is set to zero (0)
else
    echo
    echo "NOT deleting old backups because '\$maxnrOfFiles' is set to 0"
fi

#All Done

echo
echo "DONE!"
echo
