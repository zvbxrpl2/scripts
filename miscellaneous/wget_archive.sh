#!/bin/bash


wget \
    --mirror \
    --no-clobber \
    --html-extension \
    --page-requisites \
    --convert-links \
    --restrict-file-names=windows \
    --no-parent \
    --wait=1 \
    --random-wait \
    --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36" \
    $1

