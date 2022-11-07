FROM alpine
RUN apk add sftp sshpass tar 
COPY files/minestrator-backuper.sh /root/
ENTRYPOINT ["/root/minestrator-backuper.sh"]
