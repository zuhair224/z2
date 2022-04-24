#!/bin/bash

echo "Postgres latest Docker container is being pulled ⌛"
docker pull postgres:latest 
echo "Postgres latest Docker container pulled ✔️"

echo "Docker service is being built ⌛"
docker compose build
echo "Docker services are beign pulled and build ✔️"