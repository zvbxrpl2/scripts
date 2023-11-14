#!/bin/bash

for filename in *.mp4;
  do name=`basename "$filename" .mp4`
  echo "$name"
  ffmpeg -i "${filename}" -vf scale="720:480" "${name} 720p.mp4"
done
