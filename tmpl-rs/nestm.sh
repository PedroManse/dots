#! /usr/bin/env bash

mkdir "$1"
for file in "$TMPLRS_DIR/nestm/"* ; do
	rehan "$TMPLRS_DIR/nestm/$file" "PWD:$PWD/$1" "service_name:$1"
done

