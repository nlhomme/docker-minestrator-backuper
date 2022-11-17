##
# NAME             : nlhomme/docker-minestrator-backuper
# TO_BUILD         : docker build --rm -t nlhomme/docker-minestrator-backuper:latest .
# TO_RUN           : docker run -e minestratorUsername=<SFTP_USERNAME> -e minestratorPassword=<SFTP_PASSWORD> -e minestratorServer=<SFTP_SERVER> -e transfertSpeedLimit=<KILOBIT_SPEED> --rm -v <HOST_PATH>:/output -t -i nlhomme/docker-minestrator-backuper:latest
##

FROM alpine:latest
#MAINTAINER nlhomme (https://github.com/nlhomme/minestratror-backuper)

# Installing needed tools
RUN apk add openssh sshpass tar 

# Creating folder to receive then export the Minestrator backup
RUN mkdir /input /output

# Copying the backup script
COPY files/minestrator-backuper.sh minestrator-backuper.sh

# The backup script is launched at container startup
CMD ["sh", "minestrator-backuper.sh"]