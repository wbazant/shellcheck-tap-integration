#!/bin/bash

# Grab "file" as the last variable passed in
for file; do true; done

# http://tldp.org/LDP/abs/html/randomvar.html
NUM_OPTS=4
number=$RANDOM
let "number %= $NUM_OPTS"
if [ "$number" -eq 0 ]; then
  echo $file:2:6 warning: In POSIX sh, echo flags are undefined. [SC2039]
  echo $file:2:9: note: Double quote to prevent globbing and word splitting. [SC2086]
elif [ "$number" -eq 1 ]; then
  echo $file:2:2: error: You need a space after the [ and before the ]. [SC1035]
elif [ "$number" -eq 2 ]; then
	echo $file:2:9: note: Double quote to prevent globbing and word splitting. [SC2086]
else
 	true # no messages
fi
