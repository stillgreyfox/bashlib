#!/usr/bin/env bash

dir_create() {
  # determines if directory exists, if not, try to create
  # found snippet here:
  # http://stackoverflow.com/questions/793858/
  #        how-to-mkdir-only-if-a-dir-does-not-already-exist
  if [[ ! -e $1 ]];
  then
    mkdir $1
    return 0
  elif [[ ! -d $1 ]];
  then
    echo "$1 already exists, but is not a directory!" 1>&2
    return 1
  fi
}
