#!/bin/sh
echo 'Building image'
docker build ./src/ -t my-python-image