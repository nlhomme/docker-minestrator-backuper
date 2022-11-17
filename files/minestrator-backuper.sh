#!/bin/sh

# VARIABLES USED
#minestratorUsername=
#minestratorPassword= 
#minestratorServer=
#transfertSpeedLimit=


# START

# Retrieving the Minecraft server files from Minestrator via SSHPASS the Minecraft server files from Minestrator via SSHPASS (password autofill) + SFTP to the input folder
/usr/bin/sshpass -p "$minestratorPassword" /usr/bin/sftp -oHostKeyAlgorithms=+ssh-rsa -oStrictHostKeyChecking=accept-new -P 2022 -r -p -l "$transfertSpeedLimit" "$minestratorUsername"@"$minestratorServer":/ /input/

# Compressing the Minecraft files to a tar.gz archive
/usr/bin/tar zcfv output/"$(date +\%Y\%m\%d)""-minecraft.tar.gz" -C input .

# END