#!/bin/bash

echo "Ensuring that $2 exists ..."

mkdir -p $2

echo "Running rsync from $1 to $2 with additional options $3"

rsync --modify-window=1 -avzh $3 --progress $1 $2

