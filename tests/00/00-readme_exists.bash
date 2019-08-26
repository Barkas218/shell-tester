#!/usr/bin/bash

# TITLE OF THE TEST
echo "Check if README.md exists"

FILENAME="README.md"
FULLNAME="$PROJECTDIR/$FILENAME"

# wait a little bit
$SLEEP $SLEEPSECONDS

if [ -f "$FULLNAME" ];
then
    print_ok
else
    print_ko
fi