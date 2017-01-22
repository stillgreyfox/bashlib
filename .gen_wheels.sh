#!/usr/bin/env bash

# bring in other functions with source
. bashlib/in_venv.sh
. bashlib/dir_create.sh
. bashlib/confirm.sh

WHEELHOUSE=${1:-./wheelhouse}
WHEELS_TO_MAKE="requests[security] \
                numpy \
                matplotlib \
                scipy \
                scikit-learn \
                scikit-image \
                lxml"

# check to see if we're in a virtualenv
if in_venv
then
  echo "I think you're in a virtualenv";
  echo "DEACTIVATE first!";
  echo "(deactivate)";
else
  echo "I DON'T think you're in a virtualenv";
  # upgrade wheel to latest version globally
  sudo -H pip install --upgrade wheel

  # check to see if wheelhouse directory exists, creating if absent
  if dir_create $WHEELHOUSE
  then
    echo "found or created $WHEELHOUSE wheel-dir";
  else
    # we couldn't create the wheel-dir because a file exists with same name
    if confirm "$WHEELHOUSE EXISTS, is regular file, rm and mkdir? [y/N]"
    then
      echo "keeping existing $WHEELHOUSE file"
      return 1
    else
      echo "deleting $WHEELHOUSE file and making directory"
      rm $WHEELHOUSE
      if dir_create $WHEELHOUSE
      then
        echo "created $WHEELHOUSE wheel-dir";
      else
        echo "ERROR: Somehow still detecting $WHEELHOUSE as regular file";
        return 1
      fi
    fi
  fi

  # build a directory of wheels for long compile time modules
  pip wheel --wheel-dir=$WHEELHOUSE $WHEELS_TO_MAKE
fi
