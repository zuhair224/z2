# Introduction
The project contains Python's Django base app, and Postgres database. The Django version 3.12 and the postgres is created from the latest image which is 14.2 at the moment. The Postgres data in mapped to a volume in docker names `dbdata`

We have 4 scripts that runs the starts and deleteds the complete process.

## Prepare script
We get the postgres image from the docker hub repository. After that we build our Django project image.

## Start script
This script uses the `docker compose up` company to start all the container services in docker compose.

## stop script
This script stop all the container services that are mentioned within the docker compose yaml file.

## remove script
This script removes all the containers, volumes, network, and images created and utilized by the docker compose script. We are passing additional flag which does the following.
1. `-v` this removes all the volumes utilised with the docker compose script.
2. `--remove-orphans` this flag Remove containers for services not defined in the Compose file.
3. `--rmi all` this removes all the images that were created by the docker compose file