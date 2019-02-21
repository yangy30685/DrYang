#!/bin/bash

if [ -n "$1" ]  #  If command-line argument present,
then            #+ then set start-string to it.
	str0="$1"
else            #  Else use PID of script as start-string.
	str0="$$"
	echo "the pid is $$"
fi
	POS=2  # Starting from position 2 in the string.
	LEN=8  # Extract eight characters.

str1=$( echo "$str0" | md5sum | md5sum )

#  Doubly scramble     ^^^^^^   ^^^^^^
#+ by piping and repiping to md5sum.

echo "the str1 is $str1"


randstring="${str1:$POS:$LEN}"

# Can parameterize ^^^^ ^^^^

echo "$randstring"

exit $?
