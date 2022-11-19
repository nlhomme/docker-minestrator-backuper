# docker-minestrator-backuper
[![nlhomme](https://circleci.com/gh/nlhomme/docker-minestrator-backuper/tree/version1.svg?style=svg)](https://app.circleci.com/pipelines/github/nlhomme/docker-minestratror-backuper)

Sauvegarder votre serveur Mincraft hébergé chez Minestrator très facilement avec Docker.

## Avertissements

Je ne travaille pas ni à, ni pour Minestrator.</p>
Pour toute demande liée à Minestrator, contacter leur service support via [un ticket](https://minestrator.com/panel/support) ou leur [Discord](https://discord.com/invite/sa3uVjE).

Selon le support Minestrator, l'automatisation du transfert via SFTP est une pratique toléré, les abus (transferts trop fréquents, vitesse de transfert trop élevée) sont susceptibles de conduire à un blocage de l'accès/banissement, etc...

## Prérequis
Pour faire fonctionner minestrator-backuper, il vous faut:
* [Docker](https://www.docker.com)
* Récupérer vos identifiants SFTP:
  * Accèder à notre [espace client](https://minestrator.com/connexion)
  * Dérouler l'onglet "Gérer mes serveurs", cliquer celui de votre choix
  * Aller à l'onglet "Accès SFTP/MySQL", puis noter:
    * L'hôte/IP du serveur SFTP SANS "sftp://"
    * Le nom d'utilisateur du SFTP
    * Le mot de passe du SFTP

⚠️⚠️⚠️ </p>
Podman n'est actuellement pas supporté à cause d'une problématique liée au montage de volumes hôte ([plus d'infos](https://github.com/containers/podman/discussions/13537)). Cela reste néanmoins possible mais ce point ne sera pas traité ici. </p>
Toute issue à ce sujet sera donc clôturée sans discussion. </p>
⚠️⚠️⚠️ </p>

## Fonctionnement
Le conteneur docker exécute à son démarrage un script qui va:
  * Réaliser votre sauvegarde
  * La compresser sous forme d'archive .tar.gz
  * Mettre cette archive à disposition sur votre machine

Ce script utilise plusieurs variables:
* sftpUsername : Nom d'utilisateur SFTP
* sftpPassword : Mot de passe SFTP
* sftpServer : Hôte SFTP
* transfertSpeedLimit : Vitesse de transfert (en kb/s)

### Etapes de fonctionnement:
* Démarrage du conteneur
* Lancement (automatique) du script de sauvegarde "minestrator-backuper.sh"
  * Rapatriement du contenu de l'espace SFTP depuis le serveur Minestrator vers le dossier "/input" (interne au conteneur)
  * Compression du contenu du dossier "/input" vers une archive compressée et nommée "AAAAMMJJ-minestrator.tar.gz"
  * Mise à dispotition de l'archive .tar.gz à l'endroit définie par la variable docker `<HOST_PATH>`

Note: (AAAAMMYY correspondant à la date du jour, 20221118 pour le 18 novembre 2022)

## Utilisation
### Lancement du conteneur:
* Utiliser la commande suivante
```
docker run -e sftpUsername=<SFTP_USERNAME> \
    -e sftpPassword=<SFTP_PASSWORD> \
    -e sftp=<SFTP_SERVER> \
    -e transfertSpeedLimit=<KILOBIT_SPEED> \
    --rm \
    -v <HOST_PATH>:/output \
    -t \
    -i nlhomme/docker-minestrator-backuper:latest
```

* Remplacer les champs entre <> par leurs valeurs. 
* En plus des accès au SFTP, il vous faut définir les valeurs des variables:
  * <KILOBIT_SPEED>: `100000` est recommandé
  * <HOST_PATH>: répertoire de votre machine où l'archive .tar.gz sera mise à disposition

Exemple:
```
docker run -e sftpUsername=jackbauer \
    -e sftpPassword=alligator3 \
    -e sftpServer=coucoupouetpouet.minestrator.com \
    -e transfertSpeedLimit=100000 \
    --rm \
    -v /home/jackbauer/sauvegardes:/output \
    -t \
    -i nlhomme/docker-minestrator-backuper:latest
```

### Construction de l'image du conteneur
(Cette étape est facultative, la commande de lancement récupérera la dernière image depuis Docker Hub)

* Cloner le présent repository
* Ouvrir un terminal et le placer dedans
* Lancer la commande
```
docker build --rm -t nlhomme/docker-minestrator-backuper:latest .
```
