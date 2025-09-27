#!/bin/bash
echo "Hello Bash!" &
echo '$@ = '$@
echo '$* = '$*
echo '$0 = '$0
echo '$1 = '$1
echo '$# = '$#
echo '$? = '$?
echo '$$ = '$$
echo '$! = '$!

for i in "$@"; do echo "@ '$i'"; done
for i in "$*"; do echo "* '$i'"; done