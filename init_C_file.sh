#!/bin/bash

NL=$'\n'
TAB=$'\t'

echo "Ahhh yes, a new project."

echo "Warning: This script may overwrite existing files. Please check that "
echo "you do not have any important file in this directory before you proceed."
echo "Understood? (y/n)"
read confirmation
confirmation=`echo $confirmation | tr '[:upper:]' '[:lower:]'`
if [[ $confirmation != 'y' && $confirmation != 'yes' ]]
then
    exit 1
fi

# MAIN FUNCTION ==============================================================

MAIN=$"int main(int argc, char** argv) {${NL}${NL}    return 0;${NL}}"



# CREATING C FILE ============================================================
IMPORTS=$'#include <stdio.h>\n#include <stdlib.h>\n'

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
echo "$MAIN" >> $fileName


echo "Project has been initialised, now it's up to you..."
