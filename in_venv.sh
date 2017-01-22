#!/usr/bin/env bash

in_venv() {
  # determines if script is being run in a python virtualenv
  python -c 'import sys; sys.exit(int(hasattr(sys, "real_prefix")))' \
         2>/dev/null && IN_VENV=1 || IN_VENV=0
  return $IN_VENV
}
