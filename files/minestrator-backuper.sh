#!/bin/sh

# VARIABLES
#sftpUsername=
#sftpPassword=
#sftpServer=
#transfertSpeedLimit=


# START

# Retrieving the Minecraft server files from Minestrator via SSHPASS the Minecraft server files from sftp via SSHPASS (password autofill) + SFTP to the input folder
/usr/bin/sshpass -p "$sftpPassword" /usr/bin/sftp -oHostKeyAlgorithms=+ssh-rsa -oStrictHostKeyChecking=accept-new -P 2022 -r -p -l "$transfertSpeedLimit" "$sftpUsername"@"$sftpServer":/ /input/

# Compressing the Minecraft files to a tar.gz archive
/usr/bin/tar zcfv output/"$(date +\%Y\%m\%d)""-minestrator.tar.gz" -C input .

# END
exit 0
