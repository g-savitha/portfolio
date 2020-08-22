#!/bin/bash

for i in $1
do
  if [[ -e "$i.svg" ]]
  then
    echo "$i.svg exists! skipping..."
  else
    echo "Downloading $i.svg..."
    curl "https://simpleicons.org/icons/$i.svg" -O
  fi
done
