#!/bin/bash

docker compose down -v --remove-orphans --rmi all
echo "Docker Container, Network, Volume removed ✔️"