#!/bin/sh

# VARIABLES
#sftpUsername=
#sftpPassword=
#sftpServer=
#sftpInput=
#transfertSpeedLimit=


# START

# If sftpInput is empty
# Then sftpInput equals / to backup everything
if [ -z "$sftpInput" ]
then
    sftpInput="/"
fi

# Retrieving the Minecraft server files from Minestrator via SSHPASS the Minecraft server files from sftp via SSHPASS (password autofill) + SFTP to the input folder
/usr/bin/sshpass -p "$sftpPassword" /usr/bin/sftp -oHostKeyAlgorithms=+ssh-rsa -oStrictHostKeyChecking=accept-new -P 2022 -r -p -l "$transfertSpeedLimit" "$sftpUsername"@"$sftpServer":"$sftpInput" /input/ || echo "Backup failed. Please check your credentials and the server availability"

# Compressing the Minecraft files to a tar.gz archive
/usr/bin/tar zcfv output/"$(date +\%Y\%m\%d)""-minestrator.tar.gz" -C input . || echo "Compression failed. Do you have enough disk space?"

# Showing the resulting archive to the user
/bin/ls -lh output/"$(date +\%Y\%m\%d)""-minestrator.tar.gz"

# END
exit 0
