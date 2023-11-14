#!/bin/bash

yt-dlp -o "%(playlist)s/%(playlist)s - %(playlist_index)02d - %(title)s.%(ext)s" "$@"
