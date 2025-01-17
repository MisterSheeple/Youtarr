#!/bin/bash

# Read the selected directory from the config file
# Read the selected directory from the config file
youtubeOutputDirectory=$(python -c "import json; print(json.load(open('config/config.json'))['youtubeOutputDirectory'])")

docker rm -f youtubeplexarr

# Convert the windows path to Unix path and remove trailing whitespaces
## ONLY NEEDED IF RUNNING IN GIT BASH!!!
if [[ "$OSTYPE" == "msys" ]]; then
  # On windows, in git bash, the user would have selected a directory like /q/MyYoutubeDir
  # but it needs to be passed to the docker command as //q/MyYoutubeDir
  # Just prepend with an a extra / to make it work
  youtubeOutputDirectory="/$youtubeOutputDirectory"
fi

# Start the Docker container with the selected directory mounted
docker run --name youtubeplexarr -d -v $youtubeOutputDirectory:/usr/src/app/data -v /$(pwd)/config:/app/config -p 3087:3011 -e IN_DOCKER_CONTAINER=1 youtubeplexarr
