#!/bin/bash

# ghc runs multiple times per stack build, which means the interesting
# heap file gets overwritten. Start this once the library build begins
# to copy to backup.hp as ghc.hp increases in size. Exits once ghc.hp
# gets smaller than before (signalling that the interesting heap file
# has been overwritten with a new boring one).

size=$(du -b ghc.hp | awk '{ print $1}')
cp ghc.hp backup.hp

while true; do
  sleep 1
  new_size=$(du -b ghc.hp | awk '{ print $1}')
  if [ "$new_size" -gt "$size" ]; then
    echo "$new_size > $size, copying!"
    cp ghc.hp backup.hp
    size="$new_size"
  elif [ "$new_size" -lt "$size" ]; then
    echo "$new_size < $size, exiting!"
    break
  fi
done
