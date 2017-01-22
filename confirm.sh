#!/usr/bin/env bash

confirm() {
  # call with a prompt string or use a default
  read -r -p "${1:- Are you sure? [y/N]} " response
  case $response in
    [yY][eE][sS] | [yY])
      return 1
      ;;
    *)
      return 0
      ;;
  esac
}
