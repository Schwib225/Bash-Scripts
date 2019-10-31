#!/bin/bash
COUNT=0
for LETTER in {A..Z}
do
	COUNT=`/usr/bin/expr $COUNT + 1`
	echo "Letter $COUNT is [$LETTER]"
done
