#!/bin/bash

NL=$'\n'
TAB=$'\t'

echo "Ahhh yes, a new project."
# Help flag display.
if [[ $1 == '--help' ]] || [[ $1 == '-h' ]]; then
    echo "Programme flags for $0 ${NL}"
    echo "-i${TAB} Ignore potential file overwrite warning."
    echo "-h, --help${TAB}Help about programme flags."
    # Don't run the actual script.
    exit 0
fi

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


# CREATING MAKEFILE ==========================================================
touch Makefile
CFLAGS=$'CFLAGS=-std=gnu99 -Wall -pedantic\n'
CC=$'CC=gcc\n'
PHONY=$'.PHONY: debug clean\n'
DEFAULT=$'.DEFAULT_GOAL:= main\n\n'
DEBUG=$'debug: CFLAGS+= -g\ndebug: main\n'
MAIN=$'main: '
CLEAN=$"${NL}clean:${NL}${TAB}rm *.o"
TARGETS=''

MAKEFILE=$"${CFLAGS}${CC}${PHONY}${DEFAULT}${DEBUG}"

add_makefile_target () {
    target_def=$"${1//['\.c']}.o: ${1}${NL}"
    compile_line=$"${TAB}\$(CC) \$(CFLAGS) ${1} -c${NL}"
    target=$"${target_def}${compile_line}"
    TARGETS=$"${TARGETS}${NL}${target}"
    MAIN=$"${MAIN} ${1//['\.c']}.o"
}

# CREATING C FILES ===========================================================
IMPORTS=$'#include <stdio.h>\n#include <stdlib.h>\n'
MAIN_FUNC=$"int main(int argc, char** argv) {${NL}${NL}    return 0;${NL}}"

echo "How many C files do you want?"
read numFiles

echo "What are their names? Give it without .c file extension."
for fileNum in $(seq 1 $numFiles)
do
    read fileName
    echo $fileName | grep -q '\.c$' 
    if [[ $? != 0 ]]
    then
	fileName="${fileName}.c"
    fi
    touch $fileName
    echo "// ${fileName} file, responsible for..." > $fileName
    echo "$IMPORTS" >> $fileName
    if [[ $fileNum == 1 ]]
    then
	echo "$MAIN_FUNC" >> $fileName
    fi
    add_makefile_target $fileName
done

MAKEFILE=$"${MAKEFILE}${NL}${MAIN}${NL}${TARGETS}${NL}${CLEAN}"
echo $"${MAKEFILE}" > Makefile

echo "Project has been initialised, now it's up to you..."
