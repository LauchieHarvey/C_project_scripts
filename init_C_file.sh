#!/bin/bash

NL=$'\n'
TAB=$'\t'

# Help flag display.
if [[ $1 == '--help' ]] || [[ $1 == '-h' ]]; then
    echo "Programme flags for $0 ${NL}"
    echo "-i${TAB} Ignore potential file overwrite warning."
    echo "-h, --help${TAB}Help about programme flags."
    # Don't run the actual script.
    exit 0
fi

echo "Ahhh yes, a new project."

# File overwrite warning. Doesn't execute if -i flag is passed.
if [[ $1 != '-i' ]]; then
    echo "Warning: This script may overwrite existing files. Please check that "
    echo "you do not have any important file in this directory before you proceed."
    echo "Understood? (y/n)"
    read confirmation
    confirmation=`echo $confirmation | tr '[:upper:]' '[:lower:]'`
    if [[ $confirmation != 'y' && $confirmation != 'yes' ]]
    then
	exit 2
    fi
fi

MAIN_FUNC=$"int main(int argc, char** argv) {${NL}${NL}    return 0;${NL}}"



# CREATING C FILE ============================================================
IMPORTS="#include <stdio.h>${NL}#include <stdlib.h>${NL}"

echo "Enter the file name. With or without '.c' extension."
read fileName
# If the file name entered didn't have a .c extension then add one:
echo $fileName | grep -q '\.c$' 
if [[ $? != 0 ]]
then
    fileName="${fileName}.c"
fi

touch $fileName
echo "$IMPORTS" >> $fileName
echo "$MAIN_FUNC" >> $fileName


echo "Project has been initialised, now it's up to you..."
